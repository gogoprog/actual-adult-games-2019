package game;

import ash.core.Entity;
import whiplash.phaser.*;
import whiplash.math.*;

class Factory {

    static public function preload(game:phaser.Game) {
        game.load.image("car", "../data/textures/car.png");
        game.load.image("grass", "../data/textures/grass.png");
        game.load.image("grass-cut", "../data/textures/grass-cut.png");
        game.load.image("particle", "../data/textures/particle.png");
    }

    static public function init(game:phaser.Game) {
    }

    static public function createTile(i, j) {
        var e = new Entity();
        e.add(new Sprite("grass"));
        e.add(new Transform());
        e.add(new Tile(i, j));
        e.get(Sprite).anchor.set(0.5, 0.5);
        var s = Config.tileSize / 32;
        e.get(Transform).scale.set(s, s);
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
        emitter.gravity = new Point(0,0);
        return e;
    }
}
