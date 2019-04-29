package game;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;

class MachineNode extends Node<MachineNode> {
    public var transform:Transform;
    public var machine:Machine;
    public var object:Object;
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
        var machine = node.machine;
        var transform = node.transform;
        var tpos = transform.position;
        var keys = whiplash.Input.keys;
        var dir = new Coord(0, 0);
        var move = node.entity.get(Move);

        if(node.entity.get(Crash) != null ){
            return;
        }

        if(move == null) {
            var pos = machine.reachedPosition;
            pos.x = Std.int(node.object.position.x);
            pos.y = Std.int(node.object.position.y);
            var tileNode = Game.instance.grid[pos.x][pos.y];

            if(tileNode.entity.has(Grass)) {
                whiplash.AudioManager.playSound("cutting");
                tileNode.sprite.loadTexture("grass-cut");
                var e = Factory.createGrassParticles();
                e.get(Transform).position.set(tpos.x, tpos.y);
                e.get(Emitter).start(true, 2000, null, 10);
                engine.addEntity(e);
                tileNode.entity.remove(Grass);
            }
            if(tileNode.entity.has(Flower)) {
                engine.getSystem(LevelSystem).score -= 10;
                whiplash.AudioManager.playSound("ohnoes" + Std.random(3));
                tileNode.sprite.frame = 1;
                var e = Factory.createGrassParticles();
                e.get(Transform).position.set(tpos.x, tpos.y);
                e.get(Emitter).start(true, 2000, null, 10);
                engine.addEntity(e);
                tileNode.entity.remove(Flower);
            }
        } else {
            machine.time - 0;
        }

        if(keys["ArrowRight"]) {
            dir.x = 1;
            transform.rotation = 90;
        } else if(keys["ArrowLeft"]) {
            dir.x = -1;
            transform.rotation = -90;
        } else if(keys["ArrowUp"]) {
            dir.y = -1;
            transform.rotation = 0;
        } else if(keys["ArrowDown"]) {
            dir.y = 1;
            transform.rotation = 180;
        }

        if(dir.x != 0 || dir.y != 0) {
            if(move == null) {
                var from = machine.reachedPosition;
                var to = new Coord(from.x + dir.x, from.y + dir.y);

                if(to.x >= 0 && to.x < Game.instance.level.width && to.y >= 0 && to.y < Game.instance.level.height) {
                    move = new Move();
                    move.from = from;
                    move.to = to;
                    node.entity.add(move);
                } else {
                    whiplash.AudioManager.playSound("crash");
                    node.entity.add(new Crash());
                }
            }
        }

    }

    private function onNodeAdded(node:MachineNode) {
        whiplash.AudioManager.playMusic("engine");
    }

    private function onNodeRemoved(node:MachineNode) {
        whiplash.AudioManager.stopMusic();
    }
}


