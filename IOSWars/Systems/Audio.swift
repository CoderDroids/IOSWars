import AVFoundation

class Audio
{
    static let instance = Audio()
    
    private var soundPlayer: AVAudioPlayer?
    private var musicPlayer: AVAudioPlayer?
    
    private var soundEffects: [String:URL] = [:]
    private var musicTracks:  [String:URL] = [:]
    
    private var effectVolume: Float
    private var musicVolume: Float

    
    private init()
    {
        effectVolume = 1.0
        musicVolume = 1.0
        soundEffects["click"] = URL(fileURLWithPath: Bundle.main.path(forResource: "test.mp3", ofType:nil)!)
        musicTracks["main"] = URL(fileURLWithPath: Bundle.main.path(forResource: "song.mp3", ofType:nil)!)
    }
    
    func playEffect(name: String)
    {
        soundPlayer?.stop()
        try! soundPlayer = AVAudioPlayer(contentsOf: soundEffects[name]!)
        soundPlayer?.prepareToPlay()
        soundPlayer?.volume = effectVolume
        soundPlayer?.play()
    }
    
    func playMusic(name: String)
    {
        musicPlayer?.stop()
        try! musicPlayer = AVAudioPlayer(contentsOf: musicTracks[name]!)
        musicPlayer?.prepareToPlay()
        musicPlayer?.numberOfLoops = -1
        musicPlayer?.volume = musicVolume
        musicPlayer?.play()
    }

    func setEffectVolume(volume: Float)
    {
        effectVolume = volume
        soundPlayer?.volume = volume
    }
    
    func setMusicVolume(volume: Float)
    {
        musicVolume = volume
        musicPlayer?.volume = volume
    }
    
    func getMusicVolume()->Float
    {
        return musicVolume
    }
    
    func getEffectVolume()->Float
    {
        return effectVolume
    }


}
