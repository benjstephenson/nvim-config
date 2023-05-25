(import-macros {: pack} :themis.pack.lazy)
(import-macros {: nil?} :themis.lib.types)

(fn build-virtual-env [workspace]
  (local util (require :lspconfig.util))
  (let [poetry-file (vim.fn.glob (util.path.join workspace :poetry.lock))]
    (if (nil? poetry-file)
        (or (or (vim.fn.exepath :python3) (vim.fn.exepath :python)) :python)
        (let [venv (vim.fn.trim (vim.fn.system (.. "poetry --directory "
                                                   workspace "env info -p")))]
          (util.path.join venv :bin :python)))))

(fn get-python-path [workspace]
  (local util (require :lspconfig.util))
  (if vim.env.VIRTUAL_ENV
      (util.path.join vim.env.VIRTUAL_ENV :bin :python)
      (build-virtual-env workspace))

  (fn set-path [client]
    (tset client.config.settings.python :pythonPath
          (get-python-path client.config.root_dir))))

(pack :HallerPatrick/py_lsp.nvim {:ft [:python :py]} :opts
      {:host_python (vim.fn.exepath :python3) :default_venv_name :.venv})
