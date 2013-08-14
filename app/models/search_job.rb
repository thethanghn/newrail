class SearchJob < Tableless
  attr_accessible :keyword, :location
  
  column :keyword, :string, ''
  column :location, :string, ''
  
end