/*
DECOMPILER FAILED!

Underanalyzer.Decompiler.DecompilerException: Decompiler error during control flow analysis: Failed to remove else branch
 ---> Underanalyzer.Decompiler.DecompilerException: Failed to remove else branch
   at Underanalyzer.Decompiler.ControlFlow.BinaryBranch.CleanupAfterPredecessors(BinaryBranch bb, IControlFlowNode after)
   at Underanalyzer.Decompiler.ControlFlow.BinaryBranch.FindBinaryBranches(DecompileContext ctx)
   at Underanalyzer.Decompiler.DecompileContext.DecompileControlFlow()
   --- End of inner exception stack trace ---
   at Underanalyzer.Decompiler.DecompileContext.DecompileControlFlow()
   at Underanalyzer.Decompiler.DecompileContext.DecompileToAST()
   at Underanalyzer.Decompiler.DecompileContext.DecompileToString()
   at Submission#0.DumpCode(UndertaleCode code) in D:\Software\UndertaleModTool\Scripts\Resource Exporters\ExportAllCode.csx:line 48
*/