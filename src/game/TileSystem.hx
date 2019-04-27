package game;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;

class TileNode extends Node<TileNode> {
    public var transform:Transform;
    public var tile:Tile;
    public var sprite:Sprite;
}

class TileSystem extends ListIteratingSystem<TileNode> {
    private var engine:Engine;

    public function new() {
        super(TileNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    private function updateNode(node:TileNode, dt:Float):Void {
    }

    private function onNodeAdded(node:TileNode) {
        var p = node.transform.position;
        var tile = node.tile;
        p.x = Config.tileSize/2 + tile.col * Config.tileSize;
        p.y = Config.tileSize/2 + tile.row * Config.tileSize;
        Game.instance.grid[tile.col][tile.row] = node;
    }

    private function onNodeRemoved(node:TileNode) {
    }
}


