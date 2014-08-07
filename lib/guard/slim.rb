require 'guard'
require 'guard/plugin'
# require 'guard/watcher'
require 'slim'
require 'fileutils'

module Guard
  class Slim < Plugin
    ALL      = File.join '**', '*'
    Template = ::Slim::Template

    def initialize(options = {})
      UI.deprecation(":input_root has been replaced with :input") if @input = options.delete(:input_root)
      UI.deprecation(":output_root has been replaced with :output") if @output = options.delete(:output_root)
      @output   = options.delete(:output)  { Dir.getwd }
      @input    = options.delete(:input)   { Dir.getwd }
      @context  = options.delete(:context) { Object.new }
      @slim     = options.delete(:slim)    { Hash.new }

      super
    end


    def start
      UI.info 'Guard-Slim: Waiting for changes...'
    end


    def stop
      UI.info "Guard-Slim: Stopping."
    end


    def reload
      UI.info "Guard-Slim: Reload."
    end


    def run_all
      run_on_changes all_paths
    end


    def run_on_changes(paths)
      paths.each do |path|
        begin
          content = render File.read(path)
          open(build_path(path), 'w') do |file|
            @slim[:pretty] ?
              file.puts(content) :
              file.write(content)
          end
          UI.info "Guard-Slim: Rendered #{ path } to #{ build_path path }"
        rescue StandardError => error
          UI.info "Slim Error: " + error.message
        end
      end
    end


    def run_on_additions(paths)
      run_on_changes paths
    end


    def run_on_removals(paths)
      UI.info "Guard-Slim: Removal - not implemented yet."
    end

    protected

      def build_path(path)
        path     = File.expand_path(path).sub @input, @output
        dirname  = File.dirname path

        FileUtils.mkpath dirname unless File.directory? dirname

        basename = File.basename path, '.slim'
        basename << '.html' if File.extname(basename).empty?

        File.join dirname, basename
      end


      def render(source)
        Template.new(@slim) { source }.render(@context)
      rescue SyntaxError => ex
        UI.info se.message
      rescue Exception => ex
        UI.info e.message
      end


      def all_paths
        Watcher.match_files self, Dir[File.join(@input, ALL)]
      end
  end
end
