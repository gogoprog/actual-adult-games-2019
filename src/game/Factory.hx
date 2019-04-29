package game;

import ash.core.Entity;
import whiplash.phaser.*;
import whiplash.math.*;

class Factory {

    static public function preload(game:phaser.Game) {
        game.load.spritesheet('fences', '../data/spritesheets/fences.png', 32, 32, 15);
        game.load.spritesheet('flower', '../data/spritesheets/flower.png', 32, 32, 15);
    }

    static public function createTile(i, j) {
        var e = new Entity();
        e.add(new Sprite("grass"));
        e.add(new Transform());
        e.add(new Tile(i, j));
        e.get(Sprite).anchor.set(0.5, 0.5);
        var s = Config.tileSize / 32;
        e.get(Transform).scale.set(s, s);
        e.add(new Grass());
        return e;
    }

    static public function createMachine() {
        var e = new Entity();
        e.add(new Sprite("car"));
        e.add(new Transform());
        e.add(new Machine());
        e.add(new Object());
        e.get(Sprite).anchor.set(0.5, 0.5);
        return e;
    }

    static public function createGrassParticles() {
        var e = new Entity();
        e.add(new Transform());
        e.add(new AutoRemove(0.9));
        var emitter = new Emitter(32);
        e.add(emitter);
        emitter.makeParticles("particle");
        emitter.gravity = new Point(0, 0);
        return e;
    }

    static public function createBackground() {
        var e = new Entity();
        e.add(new TileSprite(640, 480, "grass-cut"));
        e.add(new Transform());
        return e;
    }

    static public function createFence(i, j, frame) {
        var e = new Entity();
        e.add(new Sprite("fences"));
        e.add(new Transform());
        e.add(new Tile(i, j));
        e.get(Sprite).anchor.set(0.5, 0.5);
        var s = Config.tileSize / 32;
        e.get(Transform).scale.set(s, s);
        e.get(Sprite).frame = frame;

        return e;
    }

    static public function convertToFlower(e:Entity) {
        if(e.get(Grass) != null) {
            e.remove(Grass);
        }

        e.get(Sprite).loadTexture("flower");
        e.get(Sprite).frame = 5;

        e.add(new Flower());
    }

}
