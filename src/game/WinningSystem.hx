package game;

import ash.core.System;
import ash.core.Engine;
import ash.core.NodeList;
import ash.core.Node;
import js.jquery.JQuery;

class WinningSystem extends ash.core.System {
    private var completed = false;
    private var continued = false;

    public function new() {
        super();
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        var id = Game.instance.level.index + 1;
        completed = false;
        continued = false;
        new JQuery(".levelId").text("" + id);

        if(Game.instance.level.index + 1 >= LevelSystem.defs.length) {
            completed = true;
            new JQuery(".gameCompleted").show();
        } else {
            new JQuery(".gameCompleted").hide();
        }

        whiplash.AudioManager.playSound("win");
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    public override function update(dt) {
        if(!continued && whiplash.Input.keys[" "]) {
            if(!completed) {
                Game.instance.level.index++;
                Game.instance.startGame();
            } else {
                Game.instance.level.index = 0;
                Game.instance.gotoMainMenu();
            }

            continued = true;
        }
    }
}

