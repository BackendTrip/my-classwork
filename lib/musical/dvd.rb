
# coding: utf-8
require 'singleton'

module Musical
  class DVD
    include Singleton
    include Musical::Util
    extend Musical::Util

    attr_accessor :title, :artist, :year

    @@path = nil

    DETECT_ERROR_MESSAGE = 'Not detect DVD, Try `DVD.load` and check your drive device path.'
    DRIVE_NOT_FOUND_MESSAGE = 'DVD drive is not found.'
    DVD_NOT_INSERTED_MESSAGE = 'DVD is not inserted.'

    def self.detect
      drutil_out = execute_command('drutil status')

      raise RuntimeError.new DRIVE_NOT_FOUND_MESSAGE  unless drutil_out
      raise RuntimeError.new DVD_NOT_INSERTED_MESSAGE unless drutil_out.include?('Name:')

      file_system = drutil_out.split("\n").select do |line|
        line.include?('Name:')
      end.first.match(/Name: (.+)/)[1]
    end

    def self.path=(path)
      @@path = path
    end

    def self.path
      @@path
    end

    def self.load(options = {})
      if @@path.nil? || options[:forcibly]
        @@path = options[:path] || self.detect
      end

      dvd = DVD.instance
      dvd.title  = options[:title]  || Musical.configuration.title
      dvd.artist = options[:artist] || Musical.configuration.artist
      dvd.year   = options[:year]   || Musical.configuration.year

      if block_given?
        yield(dvd)
      end

      dvd.info
    end

    def info
      raise RuntimeError.new DETECT_ERROR_MESSAGE unless @@path

      return @info if @info

      @info = execute_command("dvdbackup --info --input='#{@@path}'", true)
      raise RuntimeError.new DETECT_ERROR_MESSAGE if @info.empty?
      @info
    end