package funkin.data.freeplay;

import sys.io.File;
import sys.FileSystem;
import haxe.Json;

typedef PlayerDataT = {
    var name:String;
    var ownedChars:Array<String>;
    var showUnownedChars:Bool = false;
    var unlocked:Bool = true;
    var freeplayStyle:String = "bf";
    var stickerPack:String = "standard-bf";
    var freeplayDJ:FreeplayDJData;
    var charSelect:CharSelect;
    var results:Results;
}

typedef FreeplayDJData = {
    var renderType:String = "animateatlas"; // New feature cuz nobody wanna deal with fucking atlases
    var position:Array<Int> = [0, 0];
    var assetPath:String;
    var text1:String;
    var text2:String;
    var text3:String;
    var animations:Array<AnimationData>;
    var fistBump:FistBump;
    var cartoon:Cartoon;
    var charSelect:CharSelectDJ;
    var extraAnimations:Array<ExtraAnimationData>; // So you aren't limited to only 1 easter egg or 1 idle anim
}

typedef AnimationData = {
    var name:String;
    var prefix:String;
    var offsets:Array<Int> = [0, 0];
    var fps:Int = 24;
    var loop:Bool = false;
    var indices:Array<Int>;
}

typedef ExtraAnimationData = {
    var name:String;
    var animType:String = "chance";
    var waitTime:Float;
    var chance:Int;
    var sounds:Array<AnimSoundData>;
}

typedef AnimSoundData = {
    var frame:Int;
    var sound:String;
}

typedef FistBump = {
    var introStartFrame:Int;
    var introEndFrame:Int;

    var loopStartFrame:Int;
    var loopEndFrame:Int;

    var introBadStartFrame:Int;
    var introBadEndFrame:Int;

    var loopBadStartFrame:Int;
    var loopBadEndFrame:Int;
}

typedef Cartoon = {
    var soundClickFrame:Int;
    var soundCartoonFrame:Int;
    var loopBlinkFrame:Int;
    var loopFrame:Int;
    var channelChangeFrame:Int;
}

typedef CharSelect = {
    var position:Int;
    var gf:GFData;
}

typedef CharSelectDJ = { // Fuck if I know why this is the way it is
    var transitionDelay:Float;
}

typedef GFData = {
    var assetPath:String;
    var animInfoPath:String;
    var visualizer:Bool;
}

typedef Results = {
    var music:ResultsMusic;
    var perfectGold:Array<SpriteData>;
    var perfect:Array<SpriteData>;
    var excellent:Array<SpriteData>;
    var great:Array<SpriteData>;
    var good:Array<SpriteData>;
    var loss:Array<SpriteData>;
}

typedef ResultsMusic = {
    var PERFECT_GOLD:String;
    var PERFECT:String;
    var EXCELLENT:String;
    var GREAT:String;
    var GOOD:String;
    var SHIT:String;
}

typedef SpriteData = {
    var renderType:String;
    var assetPath:String;
    var filter:String;
    var offsets:Array<Int> = [0, 0];
    var scale:Float = 1.0;
    var sound:String;
    var loopFrameLabel:String;
}

class PlayerData {
    public static function load(player:String):PlayerDataT {
        try {
            var rawJson = null;
            
            var path:String = 'registry/players/' + player;
            #if MODS_ALLOWED
            var moddyFile:String = Paths.modsJsonBase(path);
            
            if(FileSystem.exists(moddyFile)) {
                rawJson = File.getContent(moddyFile).trim();
            }
            #end

            if(rawJson == null) {
                #if sys
                rawJson = File.getContent(Paths.jsonBase(path)).trim();
                #else
                rawJson = Assets.getText(Paths.jsonBase(path)).trim();
                #end	
            }

            while (!rawJson.endsWith("}"))
            {
                rawJson = rawJson.substr(0, rawJson.length - 1);
                // LOL GOING THROUGH THE BULLSHIT TO CLEAN IDK WHATS STRANGE
            }

            var f =cast Json.parse(rawJson);

            trace('Loaded playerdata!');
            trace(f);

            return f;
        }
        catch(e) {
            trace(e);
            return null;
        }
    }
}