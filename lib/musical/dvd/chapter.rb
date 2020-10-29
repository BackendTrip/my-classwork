# coding: utf-8
module Musical
  class DVD::Chapter
    include Musical::Util

    attr_accessor :vob_path, :name, :chapter_number

    DEFAULT_CHAPTER_NUMBER = 1
    DEFAULT_CHAPTER_NAME = 'default chapter name'
    DEFAULT_TITLE_NUMBER = 1

    def initialize(vob_path, options = {})
      raise ArgumentError.new 'VOB path is not given' if vob_path.nil?

      @vob_path = vob_path
      @name = options[:name] || DEFAULT_CHAPTER_NAME
      @chapter_number = options[:chapter_number] || DEFAULT_CHAPTER_NUMBER
      @title_number = option