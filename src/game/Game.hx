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

class Game {
    static public var instance:Game;
    public var grid:Array<Array<TileNode>>;
    public var cutGrid:Array<Array<Bool>>;
    public var engine:ash.core.Engine;

    public function new() {
        new JQuery(window).on("load", function() {
            whiplash.Lib.init(Config.width, Config.height, ".root", {preload:preload, create:create, update:update});
            engine = whiplash.Lib.ashEngine;
        });
        instance = this;
    }

    function preload():Void {
        AudioManager.preload(whiplash.Lib.phaserGame);
        Factory.preload(whiplash.Lib.phaserGame);
    }

    function create():Void {
        var game = whiplash.Lib.phaserGame;
        game.stage.smoothed = false;
        game.stage.disableVisibilityChange = true;
        AudioManager.init(game);
        Factory.init(game);
        whiplash.Input.setup(document.querySelector(".hud"));

        createGrid(Config.cols, Config.rows);
        createMachine();

        engine.addSystem(new TileSystem(), 1);
        engine.addSystem(new MoveSystem(), 1);
        engine.addSystem(new MachineSystem(), 2);
        engine.addSystem(new ObjectSystem(), 3);
        engine.addSystem(new AutoRemoveSystem(), 4);
    }


    function update():Void {
        var dt = whiplash.Lib.getDeltaTime() / 1000;
        engine.update(dt);
    }

    static function main():Void {
        new Game();
    }

    function createGrid(w, h) {
        grid = [];
        cutGrid = [];

        for(i in 0...w) {
            grid[i] = [];
            cutGrid[i] = [];

            for(j in 0...h) {
                var e = Factory.createTile(i, j);
                engine.addEntity(e);

                cutGrid[i][j] = false;
            }
        }
    }

    function createMachine() {
        var e = Factory.createMachine();
        var p = e.get(Transform).position;
        engine.addEntity(e);
    }
}
