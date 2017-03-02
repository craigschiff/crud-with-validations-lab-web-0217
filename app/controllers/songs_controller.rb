class SongsController < ApplicationController

  def index
    @songs = Song.all
  end

  def create
    @song = Song.new(song_params(:title, :release_year, :released, :genre, :artist_name))
    if @song.save
      @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def new
    @song = Song.new
  end

  def edit
    @song = find_song
  end

  def update
    @song = find_song
    if @song.update(song_params(:title, :release_year, :released, :genre, :artist_name))
      redirect_to @song
    else
      render :edit
    end
  end

  def show
    @song = find_song
  end

  def destroy
    @song = find_song
    @song.destroy
    redirect_to songs_path
  end
private
  def song_params(*args)
    params.require(:song).permit(*args)
  end

  def find_song
    Song.find(params[:id])
  end
end
