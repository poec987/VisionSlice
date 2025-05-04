package meta.states;

// Flixel Imports

import flixel.addons.transition.FlxTransitionableState;
import flixel.FlxCamera;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.input.touch.FlxTouch;
import flixel.math.FlxAngle;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import openfl.filters.ShaderFilter;
import openfl.display.BlendMode;

// Meta shit

import meta.data.*;
import meta.states.*;
import meta.states.substate.*;
import meta.states.editors.*;

// Fuckin Shit

import funkin.data.freeplay.PlayerData;

class VisionFreeplayState extends MusicBeatState {

    public static var curPlayer = "bf";
    public static var curPlayerData:PlayerDataT;

    public function new() {
        curPlayerData = PlayerData.load(curPlayer);
    }

    override function create() {
        super.create();
    }
}