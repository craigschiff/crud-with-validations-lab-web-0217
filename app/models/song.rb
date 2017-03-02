class Song < ActiveRecord::Base
  validates :title, presence: true
  validate :title_uniqueness
  validates :released, inclusion: { in: [true, false]}
  validates :release_year, presence: true, if: :released?
  validates :release_year, inclusion: { in: (0..2017) }, if: :released?
  validates :artist_name, presence: true


  private
  def same_name_year
    if Song.all.any? {|song| song.title == self.title && song.release_year == self.release_year && song.artist_name == self.artist_name}
      errors.add(:title, "repeat")
    end
  end

  def title_uniqueness
    song_artists = Song.all.select {|song| song if song.artist_name == self.artist_name}
    song_release_year = song_artists.select { |song| song if song.release_year == self.release_year }
    song_titles = song_release_year.select {|song| song if song.title == self.title }
    if song_titles.count > 0
      errors.add(:title, "repeat")
    end
  end

  def released?
    if self.released == true
      true
    end
  end
end
