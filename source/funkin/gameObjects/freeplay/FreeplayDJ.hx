package funkin.gameObjects.freeplay;

import gameObjects.animateatlas.AtlasFrameMaker;
import gameObjects.*;
import meta.data.*;
import meta.states.*;
import meta.states.substate.*;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.effects.FlxTrail;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import meta.data.Section.SwagSection;
#if MODS_ALLOWED
import sys.io.File;
import sys.FileSystem;
#end
import openfl.utils.AssetType;
import openfl.utils.Assets;
import haxe.Json;
import haxe.format.JsonParser;

// SHIT

import funkin.data.freeplay.PlayerData;
import meta.states.VisionFreeplayState;

using StringTools;

class FreeplayDJ extends FlxSprite {
    public var freeplayDJData:FreeplayDJData;
    public var animOffsets:Map<String, Array<Dynamic>>;

    public function new(x:Float = 0, y:Float = 0, ?character = "bf") {
        super(x, y);
        freeplayDJData = VisionFreeplayState.freeplayDJ;

        #if (haxe >= "4.0.0")
		animOffsets = new Map();
		#else
		animOffsets = new Map<String, Array<Dynamic>>();
		#end

        var imagePath = freeplayDJData.assetPath;

        switch (freeplayDJData.renderType) {
            case "packer":
				frames = Paths.getPackerAtlas(assetPath);

			case "sparrow":
				frames = Paths.getSparrowAtlas(assetPath);

			case "texture" || "animateatlas": // To give SOME compatibility to V-Slice mods
				frames = AtlasFrameMaker.construct(assetPath);
        }

        animationsArray = freeplayDJData.animations;
		if(animationsArray != null && animationsArray.length > 0) {
			for (anim in animationsArray) {
				var animAnim:String = '' + anim.prefix;
				var animName:String = '' + anim.name;
				var animFps:Int = anim.fps;
				var animLoop:Bool = !!anim.loop; //Bruh
				var animIndices:Array<Int> = anim.indices;
				if(animIndices != null && animIndices.length > 0) {
					animation.addByIndices(animAnim, animName, animIndices, "", animFps, animLoop);
				} else {
					animation.addByPrefix(animAnim, animName, animFps, animLoop);
				}

				if(anim.offsets != null && anim.offsets.length > 1) {
					addOffset(anim.anim, anim.offsets[0], anim.offsets[1]);
				}
			}
		} else {
			trace("You fucking DUMBASS");
		}
    }

    public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		specialAnim = false;
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);
	}

    public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}