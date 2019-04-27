package game;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;

class AutoRemoveNode extends Node<AutoRemoveNode> {
    public var transform:Transform;
    public var autoRemove:AutoRemove;
}

class AutoRemoveSystem extends ListIteratingSystem<AutoRemoveNode> {
    private var engine:Engine;

    public function new() {
        super(AutoRemoveNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    private function updateNode(node:AutoRemoveNode, dt:Float):Void {
        var autoRemove = node.autoRemove;

        autoRemove.time += dt;

        if(autoRemove.time >= autoRemove.duration) {
            engine.removeEntity(node.entity);
        }
    }

    private function onNodeAdded(node:AutoRemoveNode) {
        node.autoRemove.time = 0;
    }

    private function onNodeRemoved(node:AutoRemoveNode) {
    }
}


