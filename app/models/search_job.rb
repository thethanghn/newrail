class SearchJob < Struct.new(:keyword, :location, :job_types)
  def initialize(args)
    super(*args.values_at(:keyword, :location, :job_types))
  end
end