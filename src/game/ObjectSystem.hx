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
        tpos.x = Config.tileSize/2 + opos.x * Config.tileSize;
        tpos.y = Config.tileSize/2 + opos.y * Config.tileSize;
    }

    private function onNodeAdded(node:ObjectNode) {
    }

    private function onNodeRemoved(node:ObjectNode) {
    }
}


