package game;

import ash.core.System;
import ash.core.Engine;
import js.jquery.JQuery;

class LevelSystem extends ash.core.System {
    static var defs:Array<Dynamic> = [ {
        width:6,
        height:5
    }

                                     ];
    private var popup:JQuery;

    public function new() {
        super();
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        engine.removeAllEntities();
        var game = Game.instance;
        var level = game.level;
        var def = defs[level.index];
        level.width = def.width;
        level.height = def.height;
        game.createGrid(level.width, level.height);
        game.createMachine();
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    public override function update(dt) {
    }
}

