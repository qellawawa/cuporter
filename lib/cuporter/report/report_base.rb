# Copyright 2010 ThoughtWorks, Inc. Licensed under the MIT License
module Cuporter
  class ReportBase

    attr_reader :filter, :title, :doc, :root_dir, :no_leaves

    def initialize(input_file_pattern, doc, root_dir, filter_args, title = nil, no_leaves = nil)
      @input_file_pattern = input_file_pattern
      @doc = doc
      @root_dir = root_dir
      @filter = Filter.new(filter_args || {})
      @title = title
      @no_leaves = no_leaves
    end

    def files
      Dir[@input_file_pattern].collect {|f| File.expand_path f}
    end

    def self.create(type, input_file_pattern, root_dir, filter_args, format = nil, title = nil, no_leaves = nil)
      klass = Cuporter.const_get("#{type.downcase}Report".to_class_name)
      doc = Cuporter::Document.new_doc(format, type)
      klass.new(input_file_pattern, doc, root_dir, filter_args, title, no_leaves)
    end

  end
end