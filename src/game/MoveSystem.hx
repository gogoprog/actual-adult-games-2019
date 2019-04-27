package game;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;

class MoveNode extends Node<MoveNode> {
    public var transform:Transform;
    public var move:Move;
    public var object:Object;
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
        var move = node.move;

        move.time += dt;

        apply(node);
    }

    private function onNodeAdded(node:MoveNode) {
        node.move.time = node.object.nextMoveTime;
        apply(node);
    }

    private function onNodeRemoved(node:MoveNode) {
    }

    private function apply(node:MoveNode) {
        var move = node.move;
        var object = node.object;
        var duration = 1 / move.speed;
        var p = object.position;
        var from = move.from;
        var to = move.to;
        var f = move.time / duration;

        if(f > 1) {
            object.nextMoveTime = move.time - duration;
            f = 1;
        }

        object.position.x = move.from.x + (move.to.x - move.from.x) * f;
        object.position.y = move.from.y + (move.to.y - move.from.y) * f;

        if(f == 1) {
            node.entity.remove(Move);
        }
    }
}


