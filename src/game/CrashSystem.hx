package game;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;

class CrashNode extends Node<CrashNode> {
    public var transform:Transform;
    public var crash:Crash;
    public var sprite:Sprite;
}

class CrashSystem extends ListIteratingSystem<CrashNode> {
    private var engine:Engine;

    public function new() {
        super(CrashNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    private function updateNode(node:CrashNode, dt:Float):Void {
        var crash = node.crash;
        crash.time += dt;

        node.sprite.tint = phaser.Color.getRandomColor();

        if(crash.time >= 0.5) {
            node.entity.remove(Crash);
        }
    }

    private function onNodeAdded(node:CrashNode) {
    }

    private function onNodeRemoved(node:CrashNode) {
        node.sprite.tint = 0xffffff;
    }
}


