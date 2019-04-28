package game;

import ash.core.System;
import ash.core.Engine;
import ash.core.NodeList;
import ash.core.Node;
import js.jquery.JQuery;

class GrassNode extends Node<GrassNode> {
    public var grass:Grass;
}

class LevelSystem extends ash.core.System {
    static var defs:Array<Dynamic> = [ {
        width:6,
        height:5
    }, {
        width:10,
        height:3
    }
                                     ];

    private var nodeList:NodeList<GrassNode>;

    public function new() {
        super();
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        nodeList = engine.getNodeList(GrassNode);
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
        if(nodeList.empty) {
            Game.instance.changeIngameState("winning");
            Game.instance.changeUiState("winning");
        }
    }
}

