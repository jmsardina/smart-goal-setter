class Search

  def self.for(search)
    results = []
    search_condition = "%#{search}%"
    results << User.where('name LIKE ?', search_condition)
    results << Group.where('name LIKE ?', search_condition)
    results.flatten
  end
 
end