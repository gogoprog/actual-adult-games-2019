package game;

import js.Lib;
import js.jquery.*;
import js.Browser.document;
import js.Browser.window;
import phaser.Game;
import phaser.Phaser;
import ash.core.Entity;
import ash.core.Engine;
import ash.core.Node;
import whiplash.*;
import whiplash.math.*;
import whiplash.phaser.*;
import whiplash.common.components.Active;

import game.TileSystem;

class Game extends Application {
    static public var instance:Game;
    public var grid:Array<Array<TileNode>>;
    public var level:Level = new Level();

    public function new() {
        super(Config.width, Config.height, ".root");
        instance = this;
    }

    override function preload():Void {
        super.preload();
        Factory.preload(whiplash.Lib.phaserGame);
    }

    override function create():Void {
        var game = whiplash.Lib.phaserGame;
        game.stage.smoothed = false;
        game.stage.disableVisibilityChange = true;
        AudioManager.init(game);
        Factory.preload(game);
        whiplash.Input.setup(document.querySelector(".hud"));

        var menuState = createState("menu");
        createUiState("menu", ".menu");
        createUiState("hud", ".hud");
        createUiState("winning", ".winning");
        createUiState("losing", ".losing");

        engine.addSystem(new TileSystem(), 1);

        var menuState = createState("menu");

        var ingameState = createState("ingame");
        ingameState.addInstance(new MoveSystem()).withPriority(1);
        ingameState.addInstance(new MachineSystem()).withPriority(2);
        ingameState.addInstance(new ObjectSystem()).withPriority(3);
        ingameState.addInstance(new AutoRemoveSystem()).withPriority(4);

        var playingState = createIngameState("playing");
        playingState.addInstance(new LevelSystem()).withPriority(1);
        var winningState = createIngameState("winning");
        winningState.addInstance(new WinningSystem()).withPriority(1);
        var losingState = createIngameState("losing");
        losingState.addInstance(new LosingSystem()).withPriority(1);


        var e = Factory.createBackground();
        engine.addEntity(e);

        new JQuery(".play").on("click", function() {
            startGame();
        });

        engine.updateComplete.addOnce(function() {
            changeState("menu");
            changeUiState("menu");
        });
    }

    static function main():Void {
        new Game();
    }

    public function createGrid(w, h) {
        grid = [];

        for(i in 0...w) {
            grid[i] = [];

            for(j in 0...h) {
                var e = Factory.createTile(i, j);
                engine.addEntity(e);
            }
        }
    }

    public function createMachine() {
        var e = Factory.createMachine();
        var p = e.get(Transform).position;
        engine.addEntity(e);
    }

    public function startGame() {
        engine.updateComplete.addOnce(function() {
            changeUiState("hud");
            changeState("ingame");
            changeIngameState("playing");
        });
    }
}
