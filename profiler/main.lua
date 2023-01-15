require("main").load()

require("profiler.profiler_framework.api")

require("lib.loader").load{
  exclude = {"main.lua", "profiler_framework/"},
  prefix = "profiler.",
}

ProfilerMain()
