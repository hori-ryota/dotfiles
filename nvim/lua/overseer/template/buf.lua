local files = require("overseer.files")

return {
  generator = function(opts, cb)
    -- 指定されたディレクトリ内でbuf.gen.yamlファイルを探す
    local bufFile = vim.tbl_filter(function(filename)
      return filename:match("buf%.gen%.yaml$")
    end, files.list_files(opts.dir))

    local ret = {}
    -- buf.gen.yamlファイルが見つかった場合、buf generateコマンドを設定
    if #bufFile > 0 then
      table.insert(ret, {
        name = "buf generate",
        params = {
          args = { optional = true, type = "list", delimiter = " " },
        },
        builder = function(params)
          return {
            cmd = {"buf", "generate"},
            cwd = opts.dir,  -- コマンド実行のための作業ディレクトリを設定
          }
        end,
      })
    end

    cb(ret)
  end,
}
