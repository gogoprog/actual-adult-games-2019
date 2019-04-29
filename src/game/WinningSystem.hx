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
        new JQuery(".newBestTotal").hide();
        {
            var savedTxt = js.Browser.getLocalStorage().getItem("totalScore");
            var savedScore = savedTxt == null ? 0 : Std.parseInt(savedTxt);
            trace(Game.instance.totalScore);

            if(savedScore < Game.instance.totalScore) {
                js.Browser.getLocalStorage().setItem("totalScore", ""+Game.instance.totalScore);
                new JQuery(".newBestTotal").show();
                new JQuery(".bestTotalScore").text(""+Game.instance.totalScore);
            }
        }
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    public override function update(dt) {
        if(!continued && whiplash.Input.isKeyJustPressed(" ")) {
            if(!completed) {
                Game.instance.level.index++;
                Game.instance.startGame();
            } else {
                Game.instance.level.index = 0;
                Game.instance.gotoMainMenu();
                Game.instance.totalScore = 0;
            }

            continued = true;
        }
    }
}

