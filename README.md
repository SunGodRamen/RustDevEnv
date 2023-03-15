  <h1>RustDevEnv</h1>
  <p>RustDevEnv is a development environment for Rust programming using Neovim, Docker, and a variety of plugins and
    configurations to make Rust development easier and more efficient. With RustDevEnv, you can quickly set up a
    consistent Rust development environment on any computer with Docker installed.</p>

  <h2>Getting Started</h2>
  <p>To use RustDevEnv, you'll need to have Docker installed on your computer. You can download Docker for your
    operating system from the official Docker website: <a href="https://www.docker.com/get-started"
      target="_new">https://www.docker.com/get-started</a></p>
  <p>Once you have Docker installed, you can clone the RustDevEnv repository from GitHub:</p>
  <pre><div class="bg-black mb-4 rounded-md"><div class="p-4 overflow-y-auto"><code class="!whitespace-pre hljs language-bash">git <span class="hljs-built_in">clone</span> git@github.com:SunGodRamen/RustDevEnv.git</code></div></div></pre>

  <p>Then, navigate to the RustDevEnv directory and build the Docker container:</p>
  <pre><div class="bg-black mb-4 rounded-md"><div class="p-4 overflow-y-auto"><code class="!whitespace-pre hljs language-bash"><span class="hljs-built_in">cd</span> RustDevEnv
docker build --build-arg UID=$(id -u) --build-arg GID=$(id -g) -t rust-dev .</code></div></div></pre>

  <p>This will build a Docker container with the name <code>rustdev</code> that you can use for Rust development.</p>

  <p>To start the container, run the following command:</p>
  <pre><div class="bg-black mb-4 rounded-md"><div class="p-4 overflow-y-auto"><code class="!whitespace-pre hljs language-ruby">docker run -it -v <span class="hljs-variable">$(</span>pwd)<span class="hljs-symbol">:/app</span> rustdev </code></div></div></pre>

  <p>This will start the Docker container and mount the current directory as a volume inside the container, so you can
    edit Rust files using Neovim and save them to your local filesystem.</p>
 
  <h2>Packages and Remaps</h2>
  <p>RustDevEnv includes the following packages and remaps:</p>
  <h3>Plugins</h3>
  <ul>
    <li><a href="https://github.com/neoclide/coc.nvim" target="_new">coc.nvim</a>: Autocomplete and language server
      integration for Neovim.</li>
    <li><a href="https://github.com/nvim-lua/completion-nvim" target="_new">completion-nvim</a>: Auto completion for
      Neovim.</li>
    <li><a href="https://github.com/nvim-treesitter/nvim-treesitter" target="_new">nvim-treesitter</a>: Syntax
      highlighting and code parsing using treesitter.</li>
    <li><a href="https://github.com/nvim-telescope/telescope.nvim" target="_new">telescope.nvim</a>: Fuzzy finder for
      Neovim.</li>
    <li><a href="https://github.com/folke/trouble.nvim" target="_new">trouble.nvim</a>: A pretty list for showing
      diagnostics, references, and quickfixes.</li>
    <li><a href="https://github.com/tpope/vim-commentary" target="_new">vim-commentary</a>: Comment and uncomment code
      with ease.</li>
    <li><a href="https://github.com/tpope/vim-fugitive" target="_new">vim-fugitive</a>: Git wrapper for Neovim.</li>
    <li><a href="https://github.com/tpope/vim-obsession" target="_new">vim-obsession</a>: Session management for Neovim.
    </li>
    <li><a href="https://github.com/dstein64/vim-startuptime" target="_new">vim-startuptime</a>: Profile startup time
      for Neovim.</li>
    <li><a href="https://github.com/liuchengxu/vim-which-key" target="_new">vim-symbols-outline</a>: A tree view of all
      symbols in a file using symbols-outline.</li>
    <li><a href="https://github.com/tpope/vim-surround" target="_new">vim-surround</a>: Add, change, and delete
      surroundings like parentheses, brackets, and quotes.</li>
  </ul>
 
  <h3>Remaps</h3>
  <ul>
    <li><code>&lt;C-Space&gt;</code>: Trigger auto completion.</li>
    <li><code>&lt;CR&gt;</code>: Confirm auto completion.</li>
    <li><code>&lt;leader&gt;dt</code>: Toggle debug mode using dap.nvim.</li>
    <li><code>&lt;leader&gt;so</code>: Open symbols-outline.</li>
    <li><code>&lt;leader&gt;c&gt;</code>: Comment and uncomment code using commentary.vim.</li>
  </ul>

  <h2>Contributing</h2>
  <p>If you'd like to contribute to RustDevEnv, feel free to fork the repository and submit a pull request. You can also
    open an issue if you encounter any bugs or have any feature requests.</p>
  <h2>License</h2>
  <p>RustDevEnv is licensed under the MIT license. See LICENSE for details.</p>
