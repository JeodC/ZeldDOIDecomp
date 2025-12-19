function Board_Reset(arg0 = "")
{
    Status = UnknownEnum.Value_0;
    StockfishStr = StockfishStr_Start;
    SelectionX = 4;
    SelectionY = 6;
    FromSquare = [-1, -1];
    ToSquare = [-1, -1];
    HalfMove = 0;
    PromotePiece = "";
    check_castle_king = [true, true, true, true, true, true];
    King_pos = [[4, 7], [4, 0]];
    check_king = [false, false];
    moved_arr = [];
    enpassent = [];
    array_can_move = [];
    array_can_capture = [];
    piece_selected = [];
    MoveType = UnknownEnum.Value_0;
    global.Chess_Player = UnknownEnum.Value_1;
    
    for (var i = 0; i < 8; i++)
        global.Board[i] = [0, 0, 0, 0, 0, 0, 0, 0];
    
    if (arg0 != "")
    {
        FenToBoard(arg0);
    }
    else
    {
        for (var i = 0; i < 8; i++)
        {
            global.Board[i][1] = 1;
            global.Board[i][6] = -1;
        }
        
        global.Board[0][7] = -2;
        global.Board[1][7] = -3;
        global.Board[2][7] = -4;
        global.Board[3][7] = -5;
        global.Board[4][7] = -6;
        global.Board[5][7] = -4;
        global.Board[6][7] = -3;
        global.Board[7][7] = -2;
        global.Board[0][0] = 2;
        global.Board[1][0] = 3;
        global.Board[2][0] = 4;
        global.Board[3][0] = 5;
        global.Board[4][0] = 6;
        global.Board[5][0] = 4;
        global.Board[6][0] = 3;
        global.Board[7][0] = 2;
    }
}

function is_on_board(arg0, arg1)
{
    return arg0 >= 0 && arg0 <= 7 && arg1 >= 0 && arg1 <= 7;
}

function get_position_king(arg0)
{
    for (var j = 0; j < 8; j++)
    {
        for (var i = 0; i < 8; i++)
        {
            if (global.Board[i][j] == arg0)
                return [i, j];
        }
    }
}

function move(arg0 = [0, 0], arg1 = [0, 0])
{
    FromSquare = arg0;
    ToSquare = arg1;
    var __piece = global.Board[arg0[0]][arg0[1]];
    var __type_piece = abs(__piece);
    HalfMove++;
    
    if (global.Board[arg1[0]][arg1[1]] != 0)
    {
        HalfMove = 0;
        
        if (abs(global.Board[arg1[0]][arg1[1]]) == 6)
        {
            Status = UnknownEnum.Value_1;
            StockfishStr = (global.Chess_Player == UnknownEnum.Value_m1) ? StockfishStr_Win : StockfishStr_Lose;
            exit;
        }
    }
    
    if (__type_piece == 6)
    {
        if (check_castle_king[__piece > 0] && abs(arg0[0] - arg1[0]) == 2)
        {
            var __rookxold, __rookxnew;
            
            if (arg1[0] == 2)
            {
                __rookxold = 0;
                __rookxnew = 3;
            }
            else
            {
                __rookxold = 7;
                __rookxnew = 5;
            }
            
            var __rook = global.Board[__rookxold][arg0[1]];
            global.Board[__rookxold][arg0[1]] = 0;
            global.Board[__rookxnew][arg0[1]] = __rook;
        }
        
        King_pos[__piece > 0] = arg1;
    }
    else if (__type_piece == 1)
    {
        if (array_equals_([arg1[0], arg0[1]], enpassent))
            global.Board[arg1[0]][arg0[1]] = 0;
    }
    
    if (global.Board[arg1[0]][arg1[1]] == 0)
        MoveType = UnknownEnum.Value_1;
    else
        MoveType = UnknownEnum.Value_2;
    
    global.Board[arg0[0]][arg0[1]] = 0;
    global.Board[arg1[0]][arg1[1]] = __piece;
    array_push(moved_arr, [__piece, arg0, arg1]);
    enpassent = [];
    
    if (__type_piece == 1)
    {
        HalfMove = 0;
        
        if (arg1[1] == 0 || arg1[1] == 7)
        {
            if (PromotePiece != "")
                global.Board[arg1[0]][arg1[1]] = PromoteStrToPiece(PromotePiece) * sign(__piece);
            else
                global.Board[arg1[0]][arg1[1]] = 5 * sign(__piece);
        }
        else if (abs(arg1[1] - arg0[1]) == 2)
        {
            enpassent = arg1;
        }
    }
    
    PromotePiece = "";
    
    for (var i = 0; i < 6; i++)
    {
        if (check_castle_king[i])
        {
            if (global.Board[(i < 2) ? 4 : ((i < 4) ? 0 : 7)][7 - (7 * (i % 2))] != (((i < 2) ? 6 : 2) * (((i % 2) == 1) ? 1 : -1)))
                check_castle_king[i] = false;
        }
    }
    
    if (global.Chess_Player == UnknownEnum.Value_1)
    {
        AllowAIMove = false;
        alarm[0] = 45;
    }
    
    global.Chess_Player *= -1;
}

function get_legal_moves(arg0 = [0, 0])
{
    var __t = get_possible_moves(arg0);
    var i = array_length(__t[1]) - 1;
    
    while (i >= 0)
    {
        if (!_validate_move(arg0, __t[1][i]))
            array_delete(__t[1], i, 1);
        
        i--;
    }
    
    i = array_length(__t[0]) - 1;
    
    while (i >= 0)
    {
        if (!_validate_move(arg0, __t[0][i]))
            array_delete(__t[0], i, 1);
        
        i--;
    }
    
    return [__t[0], __t[1]];
}

function _validate_move(arg0, arg1)
{
    var __piece = global.Board[arg0[0]][arg0[1]];
    var __type_piece = abs(__piece);
    var __captured_en_passant = 0;
    var __captured_piece = global.Board[arg1[0]][arg1[1]];
    global.Board[arg0[0]][arg0[1]] = 0;
    global.Board[arg1[0]][arg1[1]] = __piece;
    
    if (__type_piece == 1)
    {
        if (array_length(enpassent) > 0)
        {
            if (array_equals_([arg1[0], arg0[1]], enpassent))
            {
                __captured_en_passant = global.Board[arg1[0]][arg0[1]];
                global.Board[arg1[0]][arg0[1]] = 0;
            }
        }
    }
    
    global.Board[arg0[0]][arg0[1]] = 0;
    global.Board[arg1[0]][arg1[1]] = __piece;
    var __king_p = King_pos[__piece > 0];
    
    if (__type_piece == 6)
    {
        if (abs(arg1[0] - arg0[0]) == 2)
        {
            if (check_king[__piece > 0] || _validate_move(arg1, [(arg1[0] + arg0[1]) / 2, arg1[1]]) == false)
            {
                global.Board[arg0[0]][arg0[1]] = __piece;
                global.Board[arg1[0]][arg1[1]] = __captured_piece;
                return false;
            }
        }
        
        __king_p = arg1;
    }
    
    if (global.Board[__king_p[0]][__king_p[1]] == (0 * sign(__piece)))
    {
        King_pos[__piece > 0] = get_position_king(6 * sign(__piece));
        __king_p = King_pos[__piece > 0];
    }
    
    var __chkpiece = sign(__piece) * -1;
    
    for (var j = 0; j < 8; j++)
    {
        for (var i = 0; i < 8; i++)
        {
            if (sign(global.Board[i][j]) == __chkpiece)
            {
                if (is_possible_moves_captured_king([i, j], __king_p))
                {
                    global.Board[arg0[0]][arg0[1]] = __piece;
                    global.Board[arg1[0]][arg1[1]] = __captured_piece;
                    
                    if (__captured_en_passant != 0)
                        global.Board[arg1[0]][arg0[1]] = __captured_en_passant;
                    
                    return false;
                }
            }
        }
    }
    
    global.Board[arg0[0]][arg0[1]] = __piece;
    global.Board[arg1[0]][arg1[1]] = __captured_piece;
    
    if (__captured_en_passant != 0)
        global.Board[arg1[0]][arg0[1]] = __captured_en_passant;
    
    return true;
}

function VerifyChecks()
{
    check_king = [false, false];
    var __king_p = King_pos[global.Chess_Player == UnknownEnum.Value_1];
    
    if (global.Board[__king_p[0]][__king_p[1]] == (0 * global.Chess_Player))
    {
        King_pos[global.Chess_Player == UnknownEnum.Value_1] = get_position_king(6 * global.Chess_Player);
        __king_p = King_pos[global.Chess_Player == UnknownEnum.Value_1];
    }
    
    var Victory = false;
    var __chkpiece = global.Chess_Player * -1;
    
    for (var j = 0; j < 8; j++)
    {
        for (var i = 0; i < 8; i++)
        {
            if (sign(global.Board[i][j]) == __chkpiece)
            {
                if (is_possible_moves_captured_king([i, j], __king_p))
                {
                    check_king[global.Chess_Player == UnknownEnum.Value_1] = true;
                    Victory = true;
                    break;
                }
            }
        }
        
        if (Victory)
            break;
    }
    
    var ValidMoves = false;
    
    for (var j = 0; j < 8; j++)
    {
        for (var i = 0; i < 8; i++)
        {
            if (sign(global.Board[i][j]) == global.Chess_Player)
            {
                var __t = get_legal_moves([i, j]);
                
                if (array_length(__t[0]) > 0 || array_length(__t[1]) > 0)
                {
                    ValidMoves = true;
                    break;
                }
            }
        }
        
        if (ValidMoves)
            break;
    }
    
    if (ValidMoves)
    {
        var PieceCount = 0;
        
        for (var j = 0; j < 8; j++)
        {
            for (var i = 0; i < 8; i++)
            {
                if (global.Board[i][j] != 0)
                {
                    PieceCount++;
                    
                    if (PieceCount > 2)
                        break;
                }
            }
            
            if (PieceCount > 2)
                break;
        }
        
        if (PieceCount == 2)
            ValidMoves = false;
    }
    
    if (ValidMoves)
    {
        if (check_king[1])
            StockfishStr = "Check!";
    }
    else
    {
        Status = UnknownEnum.Value_1;
        
        if (check_king[1])
            StockfishStr = StockfishStr_Win;
        else if (check_king[0])
            StockfishStr = StockfishStr_Lose;
        else
            StockfishStr = StockfishStr_Draw;
    }
}

function BoardToFen()
{
    var __arrPS = ["k", "q", "b", "n", "r", "p", "", "P", "R", "N", "B", "Q", "K"];
    var __fen = "";
    var __c = 0;
    
    for (var j = 7; j >= 0; j--)
    {
        for (var i = 0; i <= 7; i++)
        {
            if (global.Board[i][j] == 0)
            {
                __c++;
            }
            else
            {
                if (__c > 0)
                    __fen += string(__c);
                
                __fen += __arrPS[6 + global.Board[i][j]];
                __c = 0;
            }
            
            if (i == 7)
            {
                if (__c > 0)
                {
                    __fen += string(__c);
                    __c = 0;
                }
                
                if (j > 0)
                    __fen += "/";
            }
        }
    }
    
    if (global.Chess_Player == UnknownEnum.Value_1)
        __fen += " w";
    else
        __fen += " b";
    
    var __rights = "";
    
    if (check_castle_king[1])
    {
        if (check_castle_king[5])
            __rights += "K";
        
        if (check_castle_king[3])
            __rights += "Q";
    }
    
    if (check_castle_king[0])
    {
        if (check_castle_king[4])
            __rights += "k";
        
        if (check_castle_king[2])
            __rights += "q";
    }
    
    if (__rights == "")
        __fen += " -";
    else
        __fen += (" " + __rights);
    
    if (array_length(enpassent) == 0)
        __fen += " -";
    else
        __fen += (" " + chr(97 + enpassent[0]) + string(enpassent[1] + 1));
    
    __fen += (" " + string(HalfMove) + " " + string(1 + floor(HalfMove / 2)));
    return __fen;
}

function FenToBoard(arg0)
{
    var __castling = "-";
    var __enpassant = "-";
    var __fenParts = explode(" ", arg0);
    var __size_arr = array_length(__fenParts);
    
    if (__size_arr < 2)
        exit;
    
    var __pieces = __fenParts[0];
    var __turn = __fenParts[1];
    
    if (__size_arr > 2)
        __castling = __fenParts[2];
    
    if (__size_arr > 3)
        __enpassant = __fenParts[3];
    
    if (__size_arr > 4)
        HalfMove = real(__fenParts[4]);
    
    var __pieceRank = 7;
    var __pieceFile = 0;
    var __chr = "";
    
    for (var i = 7; i >= 0; i--)
        global.Board[i] = [0, 0, 0, 0, 0, 0, 0, 0];
    
    for (var i = 0; i < string_length(__pieces); i++)
    {
        __chr = string_char_at(__pieces, i + 1);
        
        switch (__chr)
        {
            case "8":
            case "7":
            case "6":
            case "5":
            case "4":
            case "3":
            case "2":
            case "1":
                __pieceFile += real(__chr);
                break;
            
            case "/":
                __pieceFile = 0;
                __pieceRank--;
                break;
            
            default:
                global.Board[__pieceFile][__pieceRank] = string_pos(__chr, "kqbnrp PRNBQK") - 7;
                __pieceFile++;
                break;
        }
    }
    
    global.Chess_Player = (__turn == "w") ? UnknownEnum.Value_1 : UnknownEnum.Value_m1;
    check_castle_king = array_create(6, false);
    
    if (string_pos("K", __castling))
    {
        check_castle_king[5] = true;
        check_castle_king[1] = true;
    }
    
    if (string_pos("Q", __castling))
    {
        check_castle_king[3] = true;
        check_castle_king[1] = true;
    }
    
    if (string_pos("k", __castling))
    {
        check_castle_king[4] = true;
        check_castle_king[0] = true;
    }
    
    if (string_pos("q", __castling))
    {
        check_castle_king[2] = true;
        check_castle_king[0] = true;
    }
    
    if (__enpassant == "-")
        enpassent = [];
    else
        enpassent = [string_ord_at(__enpassant, 1) - 97, real(string_char_at(__enpassant, 2))];
}

function PromoteStrToPiece(arg0)
{
    switch (string_lower(arg0))
    {
        case "n":
            return 3;
        
        case "b":
            return 4;
        
        case "r":
            return 2;
        
        default:
            return 5;
    }
}

function generate_moves(arg0 = [0, 0], arg1 = [[0, 0]])
{
    var __move_arr = [];
    var __capture_arr = [];
    var __new_x = 0;
    var __new_y = 0;
    
    for (var i = 0; i < array_length(arg1); i++)
    {
        __new_x = arg0[0] + arg1[i][0];
        __new_y = arg0[1] + arg1[i][1];
        
        while (is_on_board(__new_x, __new_y) && global.Board[__new_x][__new_y] == 0)
        {
            array_push(__move_arr, [__new_x, __new_y]);
            __new_x += arg1[i][0];
            __new_y += arg1[i][1];
        }
        
        if (is_on_board(__new_x, __new_y))
        {
            if (sign(global.Board[__new_x][__new_y]) != sign(global.Board[arg0[0]][arg0[1]]))
                array_push(__capture_arr, [__new_x, __new_y]);
        }
    }
    
    return [__move_arr, __capture_arr];
}

function get_possible_moves(arg0 = [0, 0])
{
    var __piece = 0;
    __piece = global.Board[arg0[0]][arg0[1]];
    
    switch (abs(__piece))
    {
        case 6:
            var __move_arr = [];
            var __capture_arr = [];
            var __new_x = 0;
            var __new_y = 0;
            
            for (var i = -1; i <= 1; i++)
            {
                for (var j = -1; j <= 1; j++)
                {
                    __new_x = arg0[0] + i;
                    __new_y = arg0[1] + j;
                    
                    if ((i != 0 || j != 0) && is_on_board(__new_x, __new_y))
                    {
                        if (global.Board[__new_x][__new_y] == 0)
                            array_push(__move_arr, [__new_x, __new_y]);
                        else if (sign(global.Board[__new_x][__new_y]) == (sign(__piece) * -1))
                            array_push(__capture_arr, [__new_x, __new_y]);
                    }
                }
            }
            
            if (check_castle_king[__piece > 0])
            {
                for (var i = 0; i < 8; i += 7)
                {
                    var __chk = true;
                    
                    if (check_castle_king[2 + real(__piece > 0) + (2 * real(i == 7))] && arg0[0] == 4 && arg0[1] == (7 - (7 * real(__piece > 0))))
                    {
                        var j = i + sign(arg0[0] - i);
                        
                        while (j != arg0[0])
                        {
                            if (global.Board[j][arg0[1]] != 0)
                            {
                                __chk = false;
                                break;
                            }
                            
                            j += sign(arg0[0] - i);
                        }
                        
                        if (__chk)
                            array_push(__move_arr, [arg0[0] - (2 * sign(arg0[0] - i)), arg0[1]]);
                    }
                }
            }
            
            return [__move_arr, __capture_arr];
        
        case 2:
            return generate_moves(arg0, [[-1, 0], [1, 0], [0, -1], [0, 1]]);
        
        case 3:
            __move_arr = [];
            __capture_arr = [];
            __new_x = 0;
            __new_y = 0;
            var __arr = [-2, -1, 1, 2];
            
            for (var i = 0; i < 4; i++)
            {
                for (var j = 0; j < 4; j++)
                {
                    if (abs(__arr[i]) != abs(__arr[j]))
                    {
                        __new_x = arg0[0] + __arr[i];
                        __new_y = arg0[1] + __arr[j];
                        
                        if (is_on_board(__new_x, __new_y))
                        {
                            if (global.Board[__new_x][__new_y] == 0)
                                array_push(__move_arr, [__new_x, __new_y]);
                            else if (sign(global.Board[__new_x][__new_y]) == (sign(__piece) * -1))
                                array_push(__capture_arr, [__new_x, __new_y]);
                        }
                    }
                }
            }
            
            return [__move_arr, __capture_arr];
        
        case 5:
            return generate_moves(arg0, [[-1, 0], [1, 0], [0, -1], [0, 1], [-1, -1], [1, 1], [1, -1], [-1, 1]]);
        
        case 4:
            return generate_moves(arg0, [[-1, -1], [1, 1], [1, -1], [-1, 1]]);
        
        default:
            __move_arr = [];
            __capture_arr = [];
            __new_y = arg0[1] + __piece;
            
            if (is_on_board(arg0[0], __new_y) && global.Board[arg0[0]][__new_y] == 0)
            {
                array_push(__move_arr, [arg0[0], __new_y]);
                
                if (arg0[1] == ((__piece < 0) ? 6 : 1))
                {
                    __new_y += __piece;
                    
                    if (global.Board[arg0[0]][__new_y] == 0)
                        array_push(__move_arr, [arg0[0], __new_y]);
                }
            }
            
            __new_y = arg0[1] + __piece;
            
            for (var i = -1; i <= 1; i += 2)
            {
                if (is_on_board(arg0[0] + i, __new_y))
                {
                    if (sign(global.Board[arg0[0] + i][__new_y]) == (sign(__piece) * -1))
                    {
                        array_push(__capture_arr, [arg0[0] + i, __new_y]);
                    }
                    else if (array_length(enpassent) > 0)
                    {
                        if (array_equals_(enpassent, [arg0[0] + i, arg0[1]]))
                            array_push(__capture_arr, [arg0[0] + i, __new_y]);
                    }
                }
            }
            
            return [__move_arr, __capture_arr];
    }
}

function generate_moves_captured_only(arg0 = [0, 0], arg1 = [[0, 0]], arg2 = [0, 0])
{
    var __new_x = 0;
    var __new_y = 0;
    
    for (var i = 0; i < array_length(arg1); i++)
    {
        __new_x = arg0[0] + arg1[i][0];
        __new_y = arg0[1] + arg1[i][1];
        
        while (is_on_board(__new_x, __new_y) && global.Board[__new_x][__new_y] == 0)
        {
            __new_x += arg1[i][0];
            __new_y += arg1[i][1];
        }
        
        if (is_on_board(__new_x, __new_y))
        {
            if (__new_x == arg2[0] && __new_y == arg2[1])
                return true;
        }
    }
    
    return false;
}

function is_possible_moves_captured_king(arg0 = [0, 0], arg1 = [0, 0])
{
    var __piece = global.Board[arg0[0]][arg0[1]];
    
    switch (abs(__piece))
    {
        case 6:
            if (array_equals_(arg0, arg1))
                return false;
            
            for (var i = -1; i <= 1; i++)
            {
                for (var j = -1; j <= 1; j++)
                {
                    if ((arg0[0] + i) == arg1[0] && (arg0[1] + j) == arg1[1])
                        return true;
                }
            }
            
            return false;
        
        case 2:
            return generate_moves_captured_only(arg0, [[-1, 0], [1, 0], [0, -1], [0, 1]], arg1);
        
        case 3:
            var __arr = [-2, -1, 1, 2];
            
            for (var i = 0; i < 4; i++)
            {
                for (var j = 0; j < 4; j++)
                {
                    if (abs(__arr[i]) != abs(__arr[j]))
                    {
                        if ((arg0[0] + __arr[i]) == arg1[0] && (arg0[1] + __arr[j]) == arg1[1])
                            return true;
                    }
                }
            }
            
            return false;
        
        case 5:
            return generate_moves_captured_only(arg0, [[-1, 0], [1, 0], [0, -1], [0, 1], [-1, -1], [1, 1], [1, -1], [-1, 1]], arg1);
        
        case 4:
            return generate_moves_captured_only(arg0, [[-1, -1], [1, 1], [1, -1], [-1, 1]], arg1);
        
        default:
            if ((arg0[1] + __piece) == arg1[1])
            {
                for (var i = -1; i <= 1; i += 2)
                {
                    if ((arg0[0] + i) == arg1[0])
                        return true;
                }
            }
            
            return false;
    }
}

function array_find(arg0 = [[-1, -1]], arg1 = [-1, -1])
{
    var __ss = array_length(arg0);
    
    for (var i = 0; i < __ss; i++)
    {
        if (array_equals_(arg0[i], arg1))
            return true;
    }
    
    return false;
}

function array_equals_(arg0 = [-1, -1], arg1 = [-1, -1])
{
    if (array_length(arg0) == 2 && array_length(arg1) == 2)
        return arg0[0] == arg1[0] && arg0[1] == arg1[1];
    else if (array_length(arg0) != array_length(arg1))
        return false;
    else
        return array_equals(arg0, arg1);
}

function explode(arg0, arg1)
{
    var arr = [];
    var str = arg1 + arg0;
    var len = string_length(arg0);
    var ind = 0;
    
    if (string_count(arg0, arg1) > 0)
    {
        repeat (string_count(arg0, str))
        {
            var pos = string_pos(arg0, str) - 1;
            
            if (string_copy(str, 1, pos) != "")
            {
                arr[ind] = string_copy(str, 1, pos);
                str = string_delete(str, 1, pos + len);
                ind++;
            }
        }
    }
    else if (arg1 != "")
    {
        arr[0] = arg1;
    }
    
    return arr;
}

enum UnknownEnum
{
    Value_m1 = -1,
    Value_0,
    Value_1,
    Value_2
}
