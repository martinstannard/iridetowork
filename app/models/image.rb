class Image < ActiveRecord::Base

  has_attachment :content_type => :image, 
    :storage => :file_system,
    :max_size => 1.megabytes,
    :tempfile_path => "/tmp",
    :thumbnails => { :huge => '400x400>', :large => '250x250>', :medium => '200x150>', :small => '100x75>', :tiny => '50x50>' }

  validates_as_attachment

  def self.parents
    Image.find(:all, :conditions => ['parent_id IS NULL'])
  end

  def thumbs_by_size
    thumbnails.sort_by { |t| t.width }
  end

end
