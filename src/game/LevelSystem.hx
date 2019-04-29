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
    }, {
        width:7,
        height:7
    } ];

    private var nodeList:NodeList<GrassNode>;
    private var score:Float;
    private var scoreInt:Int;
    private var scoreLabel:JQuery;

    public function new() {
        super();
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        nodeList = engine.getNodeList(GrassNode);
        engine.removeAllEntities();
        var e = Factory.createBackground();
        engine.addEntity(e);
        var game = Game.instance;
        var level = game.level;
        var def = defs[level.index];
        level.width = def.width;
        level.height = def.height;
        var e = Factory.createFence(-1, -1, 6);
        engine.addEntity(e);
        var e = Factory.createFence(-1, level.height, 12);
        engine.addEntity(e);
        var e = Factory.createFence(level.width, level.height, 14);
        engine.addEntity(e);
        var e = Factory.createFence(level.width, -1, 8);
        engine.addEntity(e);

        for(c in 0...level.width) {
            var e = Factory.createFence(c, -1, 1);
            engine.addEntity(e);
            var e = Factory.createFence(c, level.height, 1);
            engine.addEntity(e);
        }

        for(r in 0...level.height) {
            var e = Factory.createFence(-1, r, 4);
            engine.addEntity(e);
            var e = Factory.createFence(level.width, r, 4);
            engine.addEntity(e);
        }

        game.createGrid(level.width, level.height);
        game.createMachine();
        score = 100;
        scoreInt = 0;
        scoreLabel = new JQuery(".score");
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    public override function update(dt:Float) {
        {
            score -= dt;
            var iscore = Std.int(score);

            if(iscore != scoreInt) {
                scoreInt = iscore;
                scoreLabel.text("" + iscore);
            }
        }

        if(nodeList.empty) {
            Game.instance.changeIngameState("winning");
            Game.instance.changeUiState("winning");
        }
    }
}

