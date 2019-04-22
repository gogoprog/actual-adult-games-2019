package game;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;

class MoveNode extends Node<MoveNode> {
    public var transform:Transform;
    public var move:Move;
}

class MoveSystem extends ListIteratingSystem<MoveNode> {
    private var engine:Engine;

    public function new() {
        super(MoveNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    private function updateNode(node:MoveNode, dt:Float):Void {
    }

    private function onNodeAdded(node:MoveNode) {
        node.move.time = 0;
    }

    private function onNodeRemoved(node:MoveNode) {
    }
}


