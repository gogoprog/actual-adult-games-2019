package game;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;

class MachineNode extends Node<MachineNode> {
    public var transform:Transform;
    public var machine:Machine;
}

class MachineSystem extends ListIteratingSystem<MachineNode> {
    private var engine:Engine;

    public function new() {
        super(MachineNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    private function updateNode(node:MachineNode, dt:Float):Void {
        var tpos = node.transform.position;
        var mpos = node.machine.position;
        var keys = whiplash.Input.keys;
        var dir = new Coord(0, 0);

        if(keys["ArrowRight"]) {
            dir.x = 1;
        }

        if(keys["ArrowLeft"]) {
            dir.x = -1;
        }

        if(keys["ArrowUp"]) {
            dir.y = -1;
        }

        if(keys["ArrowDown"]) {
            dir.y = 1;
        }

        if(dir.x != 0 || dir.y != 0) {
            var move = node.entity.get(Move);

            if(move == null) {
                var from = node.machine.reachedPosition;
                var to = new Coord(from.x + dir.x, from.y + dir.y);
                move = new Move();
                move.from = from;
                move.to = to;
                node.entity.add(move);
            }
        }

        tpos.x = 16 + mpos.x * 32;
        tpos.y = 16 + mpos.y * 32;
    }

    private function onNodeAdded(node:MachineNode) {
    }

    private function onNodeRemoved(node:MachineNode) {
    }
}


