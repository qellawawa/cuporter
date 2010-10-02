# Copyright 2010 ThoughtWorks, Inc. Licensed under the MIT License

module Cuporter
  module Formatter
    module NameReport
      class HtmlNodeWriter < Cuporter::Formatter::HtmlNodeWriter

        def write_nodes(report)
          report.report_node.children.each do |child_node|
            write_node(child_node)
          end
          builder
        end

      end
    end
  end
end