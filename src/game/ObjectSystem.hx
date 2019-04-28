package game;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;

class ObjectNode extends Node<ObjectNode> {
    public var transform:Transform;
    public var object:Object;
}

class ObjectSystem extends ListIteratingSystem<ObjectNode> {
    private var engine:Engine;

    public function new() {
        super(ObjectNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    private function updateNode(node:ObjectNode, dt:Float):Void {
        var tpos = node.transform.position;
        var opos = node.object.position;
        var level = Game.instance.level;
        tpos.x = (opos.x + 0.5) * Config.tileSize + Config.width/2 - level.width * Config.tileSize * 0.5;
        tpos.y = (opos.y + 0.5) * Config.tileSize + Config.height/2 - level.height * Config.tileSize * 0.5;

        node.object.nextMoveTime = 0;
    }

    private function onNodeAdded(node:ObjectNode) {
    }

    private function onNodeRemoved(node:ObjectNode) {
    }
}


