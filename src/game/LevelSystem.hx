package game;

import ash.core.System;
import ash.core.Engine;
import ash.core.NodeList;
import ash.core.Node;
import js.jquery.JQuery;

typedef LevelData = {
    var width:Int;
    var height:Int;
    @:optional var flowers:Array<Array<Int>>;
}

class GrassNode extends Node<GrassNode> {
    public var grass:Grass;
}

class LevelSystem extends ash.core.System {
    static public var defs:Array<LevelData> = [ {
        width:6,
        height:5,
    }, {
        width:10,
        height:3
    }, {
        width:7,
        height:7,
        flowers: [
            [2, 2],
            [3, 2],
            [3, 3],
            [2, 3],
        ]
    }, {
        width:9,
        height:9,
        flowers: [
            [0, 4],
            [1, 4],
            [2, 4],
            [3, 4],
            [0, 4],
            [5, 4],
            [6, 4],
            [7, 4],
            [8, 4],
        ]
    }, {
        width:7,
        height:7,
        flowers: [
            [6, 0],
            [5, 1],
            [4, 2],
            [3, 3],
        ]
    } ];

    private var nodeList:NodeList<GrassNode>;
    public var score:Float;
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

        if(def.flowers != null) {
            for(flower in def.flowers) {
                var x = flower[0];
                var y = flower[1];
                var e = game.grid[x][y].entity;
                Factory.convertToFlower(e);
            }
        }

        score = 100;
        scoreInt = 0;
        scoreLabel = new JQuery(".score");
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    public override function update(dt:Float) {
        score -= dt;

        if(score < 0) { score = 0; }

        var iscore = Std.int(score);

        if(iscore != scoreInt) {
            scoreInt = iscore;
            scoreLabel.text("" + iscore);
        }

        var cheat = whiplash.Input.keys["F2"] && whiplash.Input.keys["F4"];

        if(nodeList.empty || cheat) {
            var levelId = Game.instance.level.index + 1;
            var savedTxt = js.Browser.getLocalStorage().getItem("level" + levelId);
            var savedScore = savedTxt == null ? 0 : Std.parseInt(savedTxt);

            if(savedScore < iscore) {
                js.Browser.getLocalStorage().setItem("level"+levelId, ""+iscore);
                new JQuery(".newBest").show();
                new JQuery(".bestScore").text("" + iscore);
            } else {
                new JQuery(".newBest").hide();
                new JQuery(".bestScore").text("" + savedScore);
            }

            Game.instance.changeIngameState("winning");
            Game.instance.changeUiState("winning");
        }
    }
}

