# encoding: utf-8

describe 'StandardParser' do
  before(:each) { @parser = StandardParser.new }

  subject { API::Release.build(@raw, @parser) }

  describe "detecting extension" do
    it "is able to detect extension" do
      @raw = "[Zero-Raws] JoJo no Kimyou na Bouken - 02 (MX 1280x720 x264 AAC).mp4"
      subject.extension.should == 'mp4'
    end

    it "unifies extension" do
      @raw = "[Zero-Raws] JoJo no Kimyou na Bouken - 02 (MX 1280x720 x264 AAC).MP4"
      subject.extension.should == 'mp4'
    end

    it "ignores extension if it is not exist" do
      @raw = "[Zero-Raws] JoJo no Kimyou na Bouken - 02 (MX 1280x720 x264 AAC)"
      subject.extension.should be_nil
    end
  end

  describe "detecting releaser" do
    it "is able to detect releaser" do
      @raw = "[Zero-Raws] JoJo no Kimyou na Bouken - 02 (MX 1280x720 x264 AAC).mp4"
      subject.releaser.should == 'Zero-Raws'
    end

    it "is able to detect releaser with kanji / hangul / etc in name" do
      @raw = "[바카-Raws] Busou Shinki #02 (TBS 1280x720 x264 AAC).mp4"
      subject.releaser.should == '바카-Raws'
    end
  end

  describe "detecting episodes" do
    it "is able to extract episodes specified through '#'" do
      @raw = "[바카-Raws] Busou Shinki #02 (TBS 1280x720 x264 AAC).mp4"
      subject.episodes.should == '02'
    end

    it "is able to detect episodes specified through hyphen" do
      @raw = "[Zero-Raws] JoJo no Kimyou na Bouken - 02 (MX 1280x720 x264 AAC).mp4"
      subject.episodes.should == '02'
    end

    it "is able to detect episodes specified through hyphen WITHOUT separator" do
      @raw = "[Zero-Raws] JoJo no Kimyou na Bouken -02 (MX 1280x720 x264 AAC).mp4"
      subject.episodes.should == '02'
    end

    it "is able to detect episode specified as a sequence" do
      @raw = "[Tsuki]_Hunter_X_Hunter_-_47-50_[704x400]"
      subject.episodes.should == '47-50'
    end

    it "is able to detect episode with a version" do
      @raw = "[Asenshi] K - 01v2 [4E7ED966].mkv"
      subject.episodes.should == '01v2'
    end

    it "is able to detect episode specified with kanji" do
      @raw = "[Raws-4U] ちとせげっちゅ！！ 第15話 「うんどうかい」 (TVS 1280x720 x264 AAC).mp4"
      subject.episodes.should == '15'
    end

  end

  describe "detecting volume" do
    it "is able to detect volume specified as 'Vol'" do
      @raw = "[Salender-Raws] Accel World Vol.3 (BD 1920x1080 x264 FLAC)"
      subject.volume.should == '3'
    end

    it "is able to detect volume specified as 'V'" do
      @raw = "[Salender-Raws] Accel World v.3 (BD 1920x1080 x264 FLAC)"
      subject.volume.should == '3'
    end

    it "is able to detect volume specified as 'Disc.'" do
      @raw = "[Salender-Raws] Accel World Disc 3 (BD 1920x1080 x264 FLAC)"
      subject.volume.should == '3'
    end

    it "ignores separators" do
      @raw = "[Salender-Raws] Accel World   v._  3 (BD 1920x1080 x264 FLAC)"
      subject.volume.should == '3'
    end
  end

  describe "detecting resolution" do
    it "is able to detect resolution specified as {WIDTH}x{HEIGHT}" do
      @raw = "[바카-Raws] Busou Shinki #02 (TBS 1280x720 x264 AAC).mp4"
      subject.resolution.should == '720'
    end

    it "is able to detect resolution specified as '{HEIGHT}p'" do
      @raw = "[HorribleSubs] Robotics;Notes - 01 [720p].mkv"
      subject.resolution.should == '720'
    end
  end

  describe "detecting audio codec" do
    it "is able to detect a FLAC audio codec" do
      @raw = "[SakuraCircle] Acchi Kocchi - 06 [h264] [BD 1920x1080] [FLAC] [391205F3].mkv"
      subject.audio.should == 'flac'
    end

    it "is able to detect a DualFLAC audio codec" do
      @raw = "[RUELL-Raws - CMS] Nisemonogatari Vol 05 (BD 1920x1080 x264 DualFLAC)"
      subject.audio.should == 'dualflac'
    end

    it "is able to detect an AAC audio codec" do
      @raw = "[Zero-Raws] Btooom! - 02 (MX 1280x720 x264 AAC).mp4"
      subject.audio.should == 'aac'
    end

    it "is able to detect an OGG audio codec" do
      @raw = "[KiteSeekers] Rio ~Rainbow Gate!~ - 05 [1280x720 H264 OGG] [5C244579].mkv"
      subject.audio.should == 'ogg'
    end

    it "is able to detect an OGG (specified as VORBIS) audio codec" do
      @raw = "[Howard] Oretachi ni Tsubasa wa Nai - Vol. 06 [BD 720p Vorbis]"
      subject.audio.should == 'vorbis'
    end
  end

  describe "detecting video codec" do
    it "is able to detect an H264 video codec" do
      @raw = "[SakuraCircle] Acchi Kocchi - 06 [H264] [BD 1920x1080] [FLAC] [391205F3].mkv"
      subject.video.should == 'h264'
    end

    it "is able to detect an X264 video codec" do
      @raw = "[바카-Raws]_Busou_Shinki_#02_(TBS_1280x720_x264_AAC).mp4"
      subject.video.should == 'x264'
    end

    it "is able to detect an XviD video codec" do
      @raw = "[UTW]_Shinsekai_Yori_-_03_[XviD][4B25563E].avi"
      subject.video.should == 'xvid'
    end

    it "is able to detect an DivX6 video codec" do
      @raw = "[MDW] _Persona _4 _- _24 _[SD][DivX][ITA][6B69DA0D].avi"
      subject.video.should == 'divx'
    end

    it "is able to detect an DivX6 video codec" do
      @raw = "[MDW] Winter Sonata - 25 [SD][648x400][DivX6][ITA].avi"
      subject.video.should == 'divx6'
    end

    it "is able to detect an MPEG2 video codec" do
      @raw = "[Leopard-Raws] Phi Brain Puzzle of God - 01 (NHK-E 1440x1080 MPEG2 AAC).ts"
      subject.video.should == 'mpeg2'
    end
  end

  it "is able to handle combo codec declaration" do
    @raw = "[SakuraCircle] Acchi Kocchi - 06 [H264+FLAC] [BD 1920x1080] [391205F3].mkv"
    subject.video.should == 'h264'
    subject.audio.should == 'flac'
  end

  describe "detecting media" do
    it "is able to detect media" do
      @raw = "[SakuraCircle] Acchi Kocchi - 06 [H264+FLAC] [BD 1920x1080] [391205F3].mkv"
      subject.media.should == 'bd'
    end

    it "is able to detect media specified with separator" do
      @raw = "[SakuraCircle] Acchi Kocchi - 06 [H264+FLAC] [Blu-Ray 1920x1080] [391205F3].mkv"
      subject.media.should == 'blu-ray'
    end
  end

  it "is able to handle nested brases" do
    @raw = "[SakuraCircle] Acchi Kocchi - 06 [H264] [BD 1920x1080 (whatever)] [FLAC] [391205F3].mkv"
    subject.releaser.should == 'SakuraCircle'
    subject.title.should == 'Acchi Kocchi'
    subject.episodes.should == '06'
    subject.media.should == 'bd'
    subject.video.should == 'h264'
    subject.audio.should == 'flac'
    subject.resolution.should == '1080'
    subject.crc32.should == '391205f3'
  end

  it "is even able to parse tsundere releases O_O" do
    @raw = "[TSuNDeRe]Needless. 02. [BDRip. h264. 1920x1080. Vorbis][73176703].mkv"
    subject.releaser.should == 'TSuNDeRe' # gomenasai
    subject.title.should == 'Needless'    # gomenasai
    subject.episodes.should == '02'       # gomenasai
    subject.media.should == 'bdrip'       # gomenasai
    subject.video.should == 'h264'        # gomenasai
    subject.audio.should == 'vorbis'      # gomenasai
    subject.resolution.should == '1080'   # gomenasai
    subject.crc32.should == '73176703'    # gomenasai
  end
end