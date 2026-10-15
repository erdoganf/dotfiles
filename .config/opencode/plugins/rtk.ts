import { Plugin } from "@opencode/plugin"
import { execFile } from "node:child_process"
import { promisify } from "node:util"

const run = promisify(execFile)

const rewriteCommand = async (command: string): Promise<string | undefined> => {
  try {
    const { stdout } = await run("rtk", ["rewrite", command])
    return stdout.trim() || undefined
  } catch (error) {
    const stdout = (error as { stdout?: string }).stdout?.trim()
    return stdout || undefined
  }
}

const rtkAvailable = async (): Promise<boolean> => {
  try {
    await run("which", ["rtk"])
    return true
  } catch {
    return false
  }
}

export default Plugin.define({
  id: "rtk",
  async setup(ctx) {
    if (!(await rtkAvailable())) {
      console.warn("[rtk] rtk binary not found in PATH — plugin disabled")
      return
    }

    await ctx.tool.hook("execute.before", async (event) => {
      const tool = String(event.tool ?? "").toLowerCase()
      if (tool !== "bash" && tool !== "shell") return

      const input = event.input as Record<string, unknown> | undefined
      const command = input?.command
      if (typeof command !== "string" || !command) return

      const rewritten = await rewriteCommand(command)
      if (rewritten && rewritten !== command) input!.command = rewritten
    })
  },
})
