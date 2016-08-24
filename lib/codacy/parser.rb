module Codacy
  module Parser

    def self.parse_file(simplecov_result)
      project_dir = Codacy::Git.work_dir

      logger.info("Parsing simplecov result to Codacy format...")
      logger.debug(simplecov_result.original_result)

      file_reports = simplecov_result.original_result.map do |k, v|
        file_dir = k.sub(project_dir, "").sub("/", "")
        coverage_lines = v.each_with_index.map do |covered, lineNr|
          if !covered.nil? && covered > 0
            [(lineNr + 1).to_s, covered]
          else
            nil
          end
        end.compact
        lines_covered = v.compact.length == 0 ? 0 : ((coverage_lines.length.to_f / v.compact.length) * 100).round
        Hash[
            [['filename', file_dir],
             ['total', lines_covered],
             ['coverage', Hash[coverage_lines]]]
        ]
      end

      total = simplecov_result.source_files.covered_percent.round

      Hash[[['total', total], ['fileReports', file_reports]]]
    end


    private

    def self.logger
      Codacy::Configuration.logger
    end
  end
end
