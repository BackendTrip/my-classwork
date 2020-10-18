# coding: utf-8
module Musical
  class DVD::Chapter
    include Musical::Util

    attr_accessor :vob_path, :name, :chapter_number

    DEFAULT_CHAPTER_NUMBER = 1
    DEFAULT_CHAPTER_NAME = 'defau