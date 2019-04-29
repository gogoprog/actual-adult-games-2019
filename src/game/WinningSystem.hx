package game;

import ash.core.System;
import ash.core.Engine;
import ash.core.NodeList;
import ash.core.Node;
import js.jquery.JQuery;

class WinningSystem extends ash.core.System {
    public function new() {
        super();
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        var id = Game.instance.level.index + 1;
        var completed = false;
        new JQuery(".levelId").text("" + id);

        if(Game.instance.level.index + 1 >= LevelSystem.defs.length) {
            completed = true;
            new JQuery(".gameCompleted").show();
        } else {
            new JQuery(".gameCompleted").hide();
        }

        Game.instance.delay(function() {
            if(!completed) {
                Game.instance.level.index++;
                Game.instance.startGame();
            } else {
                Game.instance.level.index = 0;
                Game.instance.gotoMainMenu();
            }
        }, 5);
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    public override function update(dt) {
    }
}

