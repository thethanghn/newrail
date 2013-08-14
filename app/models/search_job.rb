class SearchJob < Struct.new(:keyword, :job_category, :job_types, :locations)
  def initialize(args)
    super(*args.values_at(:keyword, :job_category, :job_types, :locations))
  end
end