defmodule GH.CLI do
  def main(args \\ []) do
    {_, words, _} = OptionParser.parse(args)

    case words do
        ["pr-open"] ->
          System.cmd("open", [GH.PR.url])
        ["pr-description"] ->
          IO.puts GH.PR.description
    end
  end
end
