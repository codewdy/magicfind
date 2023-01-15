require("main").load()

require("test.test_framework.api")

require("lib.loader").load{
  exclude = {"main.lua", "test_framework/"},
  prefix = "test.",
}

TestMain()
