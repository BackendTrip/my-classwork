require 'trollop'
require 'ruby-progressbar'
require 'fileutils'
require 'open3'
require 'ostruct'
require 'itunes-client'

require 'musical/configuration'
require 'musical/util'
require 'musical/version'
require 'musical/dvd'
require 'musical/dvd/chapter'
require 'musical/dvd/wav'
require 'musical/notification/progress_bar'

module Musical
  extend Musical::Util

  def configuration
    Configuration.config || Musical.setup
  end
  module_function :configuration

  def setup
    return unless check_env

    # init working directory
    working_dir = File.join(File.expand_path('~'), '.musical')
    FileUtils.mkdir_p(working_dir) unless File.exist?(working_dir)

    # parse options
    options = Trollop