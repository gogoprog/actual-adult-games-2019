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

        Game.instance.delay(function(){
            Game.instance.level.index++;
            Game.instance.startGame();
        }, 2);
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    public override function update(dt) {
    }
}

