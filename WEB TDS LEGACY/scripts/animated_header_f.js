(function(cjs, an) {
    var p;
    var lib = {};
    var ss = {};
    var img = {};
    lib.ssMetadata = [];
    (lib.image1 = function() { this.initialize(img.image1); }).prototype = p = new cjs.Bitmap();
    p.nominalBounds = new cjs.Rectangle(0, 0, 591, 104);
    (lib.image1_1 = function() { this.initialize(img.image1_1); }).prototype = p = new cjs.Bitmap();
    p.nominalBounds = new cjs.Rectangle(0, 0, 700, 80);
    (lib.image10 = function() { this.initialize(img.image10); }).prototype = p = new cjs.Bitmap();
    p.nominalBounds = new cjs.Rectangle(0, 0, 653, 111);
    (lib.image12 = function() { this.initialize(img.image12); }).prototype = p = new cjs.Bitmap();
    p.nominalBounds = new cjs.Rectangle(0, 0, 340, 94);
    (lib.image14 = function() { this.initialize(img.image14); }).prototype = p = new cjs.Bitmap();
    p.nominalBounds = new cjs.Rectangle(0, 0, 62, 99);
    (lib.image2 = function() { this.initialize(img.image2); }).prototype = p = new cjs.Bitmap();
    p.nominalBounds = new cjs.Rectangle(0, 0, 76, 75);
    (lib.image3 = function() { this.initialize(img.image3); }).prototype = p = new cjs.Bitmap();
    p.nominalBounds = new cjs.Rectangle(0, 0, 49, 59);
    (lib.image3_1 = function() { this.initialize(img.image3_1); }).prototype = p = new cjs.Bitmap();
    p.nominalBounds = new cjs.Rectangle(0, 0, 700, 104);
    (lib.image4 = function() { this.initialize(img.image4); }).prototype = p = new cjs.Bitmap();
    p.nominalBounds = new cjs.Rectangle(0, 0, 101, 29);

    (lib.image5 = function() { this.initialize(img.image5); }).prototype = p = new cjs.Bitmap();
    p.nominalBounds = new cjs.Rectangle(0, 0, 113, 39);
    (lib.image6 = function() { this.initialize(img.image6); }).prototype = p = new cjs.Bitmap();
    p.nominalBounds = new cjs.Rectangle(0, 0, 50, 28);
    (lib.image7 = function() { this.initialize(img.image7); }).prototype = p = new cjs.Bitmap();
    p.nominalBounds = new cjs.Rectangle(0, 0, 77, 29);
    (lib.image8 = function() { this.initialize(img.image8); }).prototype = p = new cjs.Bitmap();
    p.nominalBounds = new cjs.Rectangle(0, 0, 68, 24);
    (lib.image8_1 = function() { this.initialize(img.image8_1); }).prototype = p = new cjs.Bitmap();
    p.nominalBounds = new cjs.Rectangle(0, 0, 590, 62);
    (lib.image9 = function() { this.initialize(img.image9); }).prototype = p = new cjs.Bitmap();
    p.nominalBounds = new cjs.Rectangle(0, 0, 62, 42);
    (lib.sprite22 = function(mode, startPosition, loop) {
        if (loop == null) { loop = false; } this.initialize(mode, startPosition, loop, {});
        this.frame_0 = function() {
            var time = new Date();
            var seconds = time.getSeconds();
            var minutes = time.getMinutes();
            var hours = time.getHours();
            var ampm;
            if (hours < 12) { ampm = "AM"; } else { ampm = "PM"; }
            if (hours < 10) { hours = "0" + hours; }
            if (minutes < 10) { minutes = "0" + minutes; }
            if (seconds < 10) { seconds = "0" + seconds; }
            this.clock_txt.text = hours + ":" + minutes + ":" + seconds + " " + ampm;
        }
        this.frame_1 = function() { this.gotoAndPlay(0); }
        this.timeline.addTween(cjs.Tween.get(this).call(this.frame_0).wait(1).call(this.frame_1).wait(1));
        this.clock_txt = new cjs.Text("00:00:00 AM", "13px 'Arial'", "#FFFFFF");
        this.clock_txt.name = "clock_txt";
        this.clock_txt.lineHeight = 15;
        this.clock_txt.lineWidth = 81;
        this.clock_txt.parent = this;
        this.clock_txt.setTransform(165, 83);
        this.timeline.addTween(cjs.Tween.get(this.clock_txt).wait(2));
    }).prototype = p = new cjs.MovieClip();
    p.nominalBounds = new cjs.Rectangle(163, 81, 85, 18.8);
    (lib.shape15 = function(mode, startPosition, loop) { this.initialize(mode, startPosition, loop, {});
        this.shape = new cjs.Shape();
        this.shape.graphics.bf(img.image14, null, new cjs.Matrix2D(1, 0, 0, 1, -31, -49.5)).s().p("Ak1HvIAAvdIJrAAIAAPdg");
        this.timeline.addTween(cjs.Tween.get(this.shape).wait(1)); }).prototype = p = new cjs.MovieClip();
    p.nominalBounds = new cjs.Rectangle(-31, -49.5, 62, 99);
    (lib.shape13 = function(mode, startPosition, loop) { this.initialize(mode, startPosition, loop, {});
        this.shape = new cjs.Shape();
        this.shape.graphics.bf(img.image12, null, new cjs.Matrix2D(1, 0, 0, 1, -139.5, -47)).s().p("A1yHWIAAurMArlAAAIAAOrg");
        this.timeline.addTween(cjs.Tween.get(this.shape).wait(1)); }).prototype = p = new cjs.MovieClip();
    p.nominalBounds = new cjs.Rectangle(-139.5, -47, 340, 94);
    (lib.shape11 = function(mode, startPosition, loop) { this.initialize(mode, startPosition, loop, {});
        this.shape = new cjs.Shape();
        this.shape.graphics.bf(img.image10, null, new cjs.Matrix2D(1, 0, 0, 1, -326.5, -55.5)).s().p("EgzAAIrIAAxVMBmBAAAIAARVg");
        this.timeline.addTween(cjs.Tween.get(this.shape).wait(1)); }).prototype = p = new cjs.MovieClip();
    p.nominalBounds = new cjs.Rectangle(-326.5, -55.5, 653, 111);
    (lib.shape9 = function(mode, startPosition, loop) { this.initialize(mode, startPosition, loop, {});
        this.shape = new cjs.Shape();
        this.shape.graphics.bf(img.image8_1, null, new cjs.Matrix2D(1, 0, 0, 1, -295, -31)).s().p("EguFAE2IAAprMBcLAAAIAAJrg");
        this.timeline.addTween(cjs.Tween.get(this.shape).wait(1)); }).prototype = p = new cjs.MovieClip();
    p.nominalBounds = new cjs.Rectangle(-295, -31, 590, 62);
    (lib.shape6 = function(mode, startPosition, loop) { this.initialize(mode, startPosition, loop, {});
        this.shape = new cjs.Shape();
        this.shape.graphics.f("#000000").s().p("EgvQAIIIAAwPMBehAAAIAAQPg");
        this.shape.setTransform(302.5, 52);
        this.timeline.addTween(cjs.Tween.get(this.shape).wait(1)); }).prototype = p = new cjs.MovieClip();
    p.nominalBounds = new cjs.Rectangle(0, 0, 605, 104);
    (lib.shape4 = function(mode, startPosition, loop) { this.initialize(mode, startPosition, loop, {});
        this.shape = new cjs.Shape();
        this.shape.graphics.bf(img.image3_1, null, new cjs.Matrix2D(1, 0, 0, 1, -350, -52)).s().p("Eg2rAIIIAAwPMBtXAAAIAAQPg");
        this.shape.setTransform(0, -0.5);
        this.timeline.addTween(cjs.Tween.get(this.shape).wait(1)); }).prototype = p = new cjs.MovieClip();
    p.nominalBounds = new cjs.Rectangle(-350, -52.5, 700, 104);
    (lib.shape2 = function(mode, startPosition, loop) { this.initialize(mode, startPosition, loop, {});
        this.shape = new cjs.Shape();
        this.shape.graphics.bf(img.image1_1, null, new cjs.Matrix2D(1, 0, 0, 1, -350, -40)).s().p("Eg2rAGQIAAsfMBtXAAAIAAMfg");
        this.timeline.addTween(cjs.Tween.get(this.shape).wait(1)); }).prototype = p = new cjs.MovieClip();
    p.nominalBounds = new cjs.Rectangle(-350, -40, 700, 80);
    (lib.shape10 = function(mode, startPosition, loop) { this.initialize(mode, startPosition, loop, {});
        this.shape = new cjs.Shape();
        this.shape.graphics.bf(img.image9, null, new cjs.Matrix2D(1, 0, 0, 1, -31, -21)).s().p("Ak1DSIAAmjIJrAAIAAGjg");
        this.timeline.addTween(cjs.Tween.get(this.shape).wait(1)); }).prototype = p = new cjs.MovieClip();
    p.nominalBounds = new cjs.Rectangle(-31, -21, 62, 42);
    (lib.shape8 = function(mode, startPosition, loop) { if (loop == null) { loop = false; } this.initialize(mode, startPosition, loop, {});
        this.instance = new lib.image7();
        this.instance.parent = this;
        this.instance.setTransform(-39, -15);
        this.timeline.addTween(cjs.Tween.get(this.instance).wait(1)); }).prototype = p = new cjs.MovieClip();
    p.nominalBounds = new cjs.Rectangle(-39, -15, 77.5, 29.5);
    (lib.shape6_1 = function(mode, startPosition, loop) { this.initialize(mode, startPosition, loop, {});
        this.shape_1 = new cjs.Shape();
        this.shape_1.graphics.bf(img.image5, null, new cjs.Matrix2D(1, 0, 0, 1, -56.5, -19.5)).s().p("Ao0DDIAAmFIRpAAIAAGFg");
        this.timeline.addTween(cjs.Tween.get(this.shape_1).wait(1)); }).prototype = p = new cjs.MovieClip();
    p.nominalBounds = new cjs.Rectangle(-56.5, -19.5, 113, 39);
    (lib.shape4_1 = function(mode, startPosition, loop) { this.initialize(mode, startPosition, loop, {});
        this.shape_1 = new cjs.Shape();
        this.shape_1.graphics.bf(img.image3, null, new cjs.Matrix2D(1, 0, 0, 1, -24.5, -29.5)).s().p("Aj0EnIAApNIHpAAIAAJNg");
        this.timeline.addTween(cjs.Tween.get(this.shape_1).wait(1)); }).prototype = p = new cjs.MovieClip();
    p.nominalBounds = new cjs.Rectangle(-24.5, -29.5, 49, 59);
    (lib.shape2_1 = function(mode, startPosition, loop) { this.initialize(mode, startPosition, loop, {});
        this.shape_1 = new cjs.Shape();
        this.shape_1.graphics.bf(img.image1, null, new cjs.Matrix2D(1, 0, 0, 1, -295.5, -52)).s().p("EguKAIIIAAwPMBcVAAAIAAQPg");
        this.timeline.addTween(cjs.Tween.get(this.shape_1).wait(1)); }).prototype = p = new cjs.MovieClip();
    p.nominalBounds = new cjs.Rectangle(-295.5, -52, 591, 104);
    (lib.shape9_1 = function(mode, startPosition, loop) { this.initialize(mode, startPosition, loop, {});
        this.shape_1 = new cjs.Shape();
        this.shape_1.graphics.bf(img.image8, null, new cjs.Matrix2D(1, 0, 0, 1, -34, -12)).s().p("AlTB4IAAjvIKnAAIAADvg");
        this.timeline.addTween(cjs.Tween.get(this.shape_1).wait(1)); }).prototype = p = new cjs.MovieClip();
    p.nominalBounds = new cjs.Rectangle(-34, -12, 68, 24);
    (lib.shape7 = function(mode, startPosition, loop) { this.initialize(mode, startPosition, loop, {});
        this.shape = new cjs.Shape();
        this.shape.graphics.bf(img.image6, null, new cjs.Matrix2D(1, 0, 0, 1, -25, -14)).s().p("Aj5CMIAAkXIHzAAIAAEXg");
        this.timeline.addTween(cjs.Tween.get(this.shape).wait(1)); }).prototype = p = new cjs.MovieClip();
    p.nominalBounds = new cjs.Rectangle(-25, -14, 50, 28);
    (lib.shape5 = function(mode, startPosition, loop) { this.initialize(mode, startPosition, loop, {});
        this.shape = new cjs.Shape();
        this.shape.graphics.bf(img.image4, null, new cjs.Matrix2D(1, 0, 0, 1, -50.5, -14.5)).s().p("An4CRIAAkhIPxAAIAAEhg");
        this.timeline.addTween(cjs.Tween.get(this.shape).wait(1)); }).prototype = p = new cjs.MovieClip();
    p.nominalBounds = new cjs.Rectangle(-50.5, -14.5, 101, 29);
    (lib.shape3 = function(mode, startPosition, loop) { this.initialize(mode, startPosition, loop, {});
        this.shape = new cjs.Shape();
        this.shape.graphics.bf(img.image2, null, new cjs.Matrix2D(1, 0, 0, 1, -38, -37.5)).s().p("Al7F3IAArtIL3AAIAALtg");
        this.shape.setTransform(0.4, 1);
        this.timeline.addTween(cjs.Tween.get(this.shape).wait(1)); }).prototype = p = new cjs.MovieClip();
    p.nominalBounds = new cjs.Rectangle(-37.6, -36.5, 76, 75);
    (lib.shape1 = function(mode, startPosition, loop) { this.initialize(mode, startPosition, loop, {});
        this.shape = new cjs.Shape();
        this.shape.graphics.f("#4E8CDA").s().p("EguKAIIIAAwPMBcVAAAIAAQPg");
        this.shape.setTransform(-86.9, -2);
        this.timeline.addTween(cjs.Tween.get(this.shape).wait(1)); }).prototype = p = new cjs.MovieClip();
    p.nominalBounds = new cjs.Rectangle(-382.4, -54, 591, 104);
    (lib.sprite11 = function(mode, startPosition, loop) {
        if (loop == null) { loop = false; } this.initialize(mode, startPosition, loop, {});
        this.frame_771 = function() { this.gotoAndPlay(321); }
        this.timeline.addTween(cjs.Tween.get(this).wait(771).call(this.frame_771).wait(1));
        this.instance = new lib.shape6_1("synched", 0);
        this.instance.parent = this;
        this.instance.setTransform(411, -6.5);
        this.instance.alpha = 0.602;
        this.instance._off = true;
        this.timeline.addTween(cjs.Tween.get(this.instance).wait(298).to({ _off: false }, 0).to({ x: 67.8, alpha: 0.672 }, 473).wait(1));
        this.instance_1 = new lib.shape6_1("synched", 0);
        this.instance_1.parent = this;
        this.instance_1.setTransform(250.5, -6.5);
        this.instance_1.alpha = 0.039;
        this.instance_1._off = true;
        this.timeline.addTween(cjs.Tween.get(this.instance_1).wait(88).to({ _off: false }, 0).to({ x: 247.5, alpha: 0.602 }, 9).to({ x: 67.8, alpha: 0.672 }, 224).to({ x: -293.2, alpha: 0.809 }, 450).wait(1));
        this.instance_2 = new lib.shape8("synched", 0);
        this.instance_2.parent = this;
        this.instance_2.setTransform(393, 6);
        this.instance_2.alpha = 0;
        this.instance_2._off = true;
        this.timeline.addTween(cjs.Tween.get(this.instance_2).wait(737).to({ _off: false }, 0).to({ x: 358.3, alpha: 1 }, 34).wait(1));
        this.instance_3 = new lib.shape10("synched", 0);
        this.instance_3.parent = this;
        this.instance_3.setTransform(384.5, 27);
        this.instance_3._off = true;
        this.timeline.addTween(cjs.Tween.get(this.instance_3).wait(612).to({ _off: false }, 0).to({ x: 238.6, alpha: 0.969 }, 159).wait(1));
        this.instance_4 = new lib.shape10("synched", 0);
        this.instance_4.parent = this;
        this.instance_4.setTransform(386.5, 27);
        this.instance_4._off = true;
        this.timeline.addTween(cjs.Tween.get(this.instance_4).wait(189).to({ _off: false }, 0).to({ x: 238.6, alpha: 0.969 }, 132).to({ x: -265.5, alpha: 0.859 }, 450).wait(1));
        this.instance_5 = new lib.shape8("synched", 0);
        this.instance_5.parent = this;
        this.instance_5.setTransform(393, 6);
        this.instance_5._off = true;
        this.timeline.addTween(cjs.Tween.get(this.instance_5).wait(285).to({ _off: false }, 0).to({ x: 389.2 }, 4).to({ x: 358.3 }, 32).to({ x: -75.6, alpha: 0.922 }, 450).wait(1));
        this.instance_6 = new lib.shape10("synched", 0);
        this.instance_6.parent = this;
        this.instance_6.setTransform(-118.3, 27);
        this.instance_6.alpha = 0.109;
        this.instance_6._off = true;
        this.timeline.addTween(cjs.Tween.get(this.instance_6).wait(79).to({ _off: false }, 0).to({ x: -120.9, alpha: 1 }, 18).to({ x: -364.3 }, 384).wait(1).to({ x: -365 }, 0).wait(290));
        this.instance_7 = new lib.shape8("synched", 0);
        this.instance_7.parent = this;
        this.instance_7.setTransform(64, 6);
        this.instance_7.alpha = 0;
        this.instance_7._off = true;
        this.timeline.addTween(cjs.Tween.get(this.instance_7).wait(82).to({ _off: false }, 0).to({ x: 61.6, alpha: 1 }, 15).to({ x: -75.6, alpha: 0.922 }, 224).to({ x: -351.2, alpha: 0.75 }, 450).wait(1));
        this.instance_8 = new lib.shape6_1("synched", 0);
        this.instance_8.parent = this;
        this.instance_8.setTransform(-180.4, 1);
        this.instance_8.alpha = 0;
        this.instance_8._off = true;
        this.timeline.addTween(cjs.Tween.get(this.instance_8).wait(73).to({ _off: false }, 0).to({ x: -182.5, alpha: 1 }, 24).to({ x: -392.9 }, 414).wait(1).to({ x: -393.4 }, 0).wait(260));
        this.instance_9 = new lib.shape4_1("synched", 0);
        this.instance_9.parent = this;
        this.instance_9.setTransform(-98.4, -8.5);
        this.instance_9.alpha = 0;
        this.timeline.addTween(cjs.Tween.get(this.instance_9).to({ alpha: 0.98 }, 67).wait(1).to({ alpha: 1 }, 0).wait(704));
        this.instance_10 = new lib.shape2_1("synched", 0);
        this.instance_10.parent = this;
        this.instance_10.setTransform(58, 3);
        this.timeline.addTween(cjs.Tween.get(this.instance_10).wait(772));
    }).prototype = p = new cjs.MovieClip();
    p.nominalBounds = new cjs.Rectangle(-237.5, -49, 591, 104);
    (lib.sprite16 = function(mode, startPosition, loop) {
        this.initialize(mode, startPosition, loop, {});
        this.frame_27 = function() { this.stop(); }
        this.timeline.addTween(cjs.Tween.get(this).wait(27).call(this.frame_27).wait(1));
        this.instance = new lib.shape15("synched", 0);
        this.instance.parent = this;
        this.instance.setTransform(173, -191.5);
        this.instance._off = true;
        this.timeline.addTween(cjs.Tween.get(this.instance).wait(16).to({ _off: false }, 0).to({ y: -8.6 }, 7).wait(1).to({ y: 17.5 }, 0).wait(1).to({ startPosition: 0 }, 0).wait(1).to({ y: 18.5 }, 0).wait(1).to({ y: 17.5 }, 0).wait(1));
        this.instance_1 = new lib.shape13("synched", 0);
        this.instance_1.parent = this;
        this.instance_1.setTransform(-78, -170);
        this.instance_1._off = true;
        this.timeline.addTween(cjs.Tween.get(this.instance_1).wait(5).to({ _off: false }, 0).to({ y: -9 }, 9).wait(1).to({ y: -10 }, 0).wait(1).to({ rotation: -0.5, x: -77.6, y: -8.3 }, 0).wait(1).to({ rotation: -1.2, x: -77.2, y: -6.6 }, 0).wait(11));
        this.instance_2 = new lib.shape11("synched", 0);
        this.instance_2.parent = this;
        this.instance_2.setTransform(0, -11.5);
        this.timeline.addTween(cjs.Tween.get(this.instance_2).to({ startPosition: 0 }, 13).wait(1).to({ y: -4.5 }, 0).wait(1).to({ y: -8 }, 0).wait(1).to({ y: -11.5 }, 0).to({ startPosition: 0 }, 9).wait(1).to({ y: -10.5 }, 0).wait(1).to({ y: -11.5 }, 0).wait(1));
    }).prototype = p = new cjs.MovieClip();
    p.nominalBounds = new cjs.Rectangle(-326.5, -67, 653, 111);
    (lib.sprite10 = function(mode, startPosition, loop) {
        this.initialize(mode, startPosition, loop, {});
        this.frame_1506 = function() { this.gotoAndPlay(988); }
        this.timeline.addTween(cjs.Tween.get(this).wait(1506).call(this.frame_1506).wait(2));
        this.instance = new lib.shape5("synched", 0);
        this.instance.parent = this;
        this.instance.setTransform(267.8, -14);
        this.timeline.addTween(cjs.Tween.get(this.instance).to({ x: -440.4 }, 878).wait(1).to({ x: -441.2 }, 0).wait(629));
        this.instance_1 = new lib.shape7("synched", 0);
        this.instance_1.parent = this;
        this.instance_1.setTransform(243.8, 19.5);
        this.instance_1._off = true;
        this.timeline.addTween(cjs.Tween.get(this.instance_1).wait(379).to({ _off: false }, 0).to({ x: -439.3 }, 798).wait(1).to({ x: -440.1 }, 0).wait(330));
        this.instance_2 = new lib.shape7("synched", 0);
        this.instance_2.parent = this;
        this.instance_2.setTransform(243.8, 19.5);
        this.instance_2._off = true;
        this.timeline.addTween(cjs.Tween.get(this.instance_2).wait(1110).to({ _off: false }, 0).to({ x: -277 }, 396).wait(2));
        this.instance_3 = new lib.shape7("synched", 0);
        this.instance_3.parent = this;
        this.instance_3.setTransform(238.8, 39.5);
        this.instance_3._off = true;
        this.timeline.addTween(cjs.Tween.get(this.instance_3).wait(1079).to({ _off: false }, 0).to({ x: -100.4 }, 427).wait(2));
        this.instance_4 = new lib.shape7("synched", 0);
        this.instance_4.parent = this;
        this.instance_4.setTransform(238.8, 39.5);
        this.instance_4._off = true;
        this.timeline.addTween(cjs.Tween.get(this.instance_4).wait(561).to({ _off: false }, 0).to({ x: -425.3 }, 836).wait(1).to({ x: -426.1 }, 0).wait(110));
        this.instance_5 = new lib.shape9_1("synched", 0);
        this.instance_5.parent = this;
        this.instance_5.setTransform(272.8, -30.5, 1.479, 0.75, -2.3);
        this.instance_5._off = true;
        this.timeline.addTween(cjs.Tween.get(this.instance_5).wait(948).to({ _off: false }, 0).to({ scaleX: 1.47, scaleY: 0.75, x: 264, y: -30.1 }, 13).to({ scaleX: 1, scaleY: 1, rotation: 0, x: -82.2, y: 0.5 }, 545).wait(2));
        this.instance_6 = new lib.shape9_1("synched", 0);
        this.instance_6.parent = this;
        this.instance_6.setTransform(250.8, 0.5);
        this.instance_6._off = true;
        this.timeline.addTween(cjs.Tween.get(this.instance_6).wait(599).to({ _off: false }, 0).to({ x: -82.2 }, 389).to({ x: -432.3 }, 409).wait(1).to({ x: -433.2 }, 0).wait(110));
        this.instance_7 = new lib.shape3("synched", 0);
        this.instance_7.parent = this;
        this.instance_7.setTransform(-265.4, 0);
        this.instance_7.alpha = 0;
        this.timeline.addTween(cjs.Tween.get(this.instance_7).to({ alpha: 0.012 }, 1).to({ alpha: 0.02 }, 1).to({ alpha: 0.039 }, 2).to({ alpha: 0.051 }, 1).to({ alpha: 0.078 }, 3).to({ alpha: 0.09 }, 1).to({ alpha: 0.102 }, 1).to({ alpha: 0.109 }, 1).to({ alpha: 0.121 }, 1).to({ alpha: 0.141 }, 2).to({ alpha: 0.148 }, 1).to({ alpha: 0.172 }, 2).to({ alpha: 0.18 }, 1).to({ alpha: 0.211 }, 3).to({ alpha: 0.219 }, 1).to({ alpha: 0.25 }, 2).to({ startPosition: 0 }, 1).to({ alpha: 0.281 }, 2).to({ alpha: 0.289 }, 1).to({ alpha: 0.32 }, 3).to({ alpha: 0.328 }, 1).to({ alpha: 0.34 }, 1).to({ alpha: 0.352 }, 1).to({ alpha: 0.359 }, 1).to({ alpha: 0.379 }, 2).to({ alpha: 0.391 }, 1).to({ alpha: 0.41 }, 2).to({ alpha: 0.422 }, 1).to({ alpha: 0.449 }, 3).to({ alpha: 0.461 }, 1).to({ alpha: 0.469 }, 1).to({ alpha: 0.48 }, 1).to({ alpha: 0.488 }, 1).to({ alpha: 0.512 }, 2).to({ alpha: 0.52 }, 1).to({ alpha: 0.539 }, 2).to({ alpha: 0.551 }, 1).to({ alpha: 0.578 }, 3).to({ alpha: 0.59 }, 1).to({ alpha: 0.602 }, 1).to({ alpha: 0.609 }, 1).to({ alpha: 0.621 }, 1).to({ alpha: 0.641 }, 2).to({ alpha: 0.648 }, 1).to({ alpha: 0.672 }, 2).to({ alpha: 0.68 }, 1).to({ alpha: 0.711 }, 3).to({ alpha: 0.719 }, 1).to({ alpha: 0.75 }, 2).to({ startPosition: 0 }, 1).to({ alpha: 0.781 }, 2).to({ alpha: 0.789 }, 1).to({ alpha: 0.82 }, 3).to({ alpha: 0.828 }, 1).to({ alpha: 0.84 }, 1).to({ alpha: 0.852 }, 1).to({ alpha: 0.859 }, 1).to({ alpha: 0.879 }, 2).to({ alpha: 0.891 }, 1).to({ alpha: 0.91 }, 2).to({ alpha: 0.922 }, 1).to({ alpha: 0.949 }, 3).to({ alpha: 0.961 }, 1).to({ alpha: 0.969 }, 1).to({ alpha: 0.98 }, 1).to({ alpha: 0.988 }, 1).to({ alpha: 1 }, 1).to({ startPosition: 0 }, 2).to({ startPosition: 0 }, 1).to({ startPosition: 0 }, 5).to({ startPosition: 0 }, 1).to({ startPosition: 0 }, 5).to({ startPosition: 0 }, 1).to({ startPosition: 0 }, 5).to({ startPosition: 0 }, 1).to({ startPosition: 0 }, 5).to({ startPosition: 0 }, 1).to({ startPosition: 0 }, 5).to({ startPosition: 0 }, 1).to({ startPosition: 0 }, 5).to({ startPosition: 0 }, 1).to({ startPosition: 0 }, 5).to({ startPosition: 0 }, 1).to({ startPosition: 0 }, 5).to({ startPosition: 0 }, 1).to({ startPosition: 0 }, 5).to({ startPosition: 0 }, 2).wait(1).to({ startPosition: 0 }, 0).wait(1351));
        this.instance_8 = new lib.shape1("synched", 0);
        this.instance_8.parent = this;
        this.timeline.addTween(cjs.Tween.get(this.instance_8).wait(1508));
    }).prototype = p = new cjs.MovieClip();
    p.nominalBounds = new cjs.Rectangle(-382.4, -54, 700.7, 104);
    (lib.sprite12 = function(mode, startPosition, loop) {
        this.initialize(mode, startPosition, loop, {});
        this.frame_0 = function() {}
        this.frame_39 = function() { this.stop(); }
        this.timeline.addTween(cjs.Tween.get(this).call(this.frame_0).wait(39).call(this.frame_39).wait(1));
        this.noche_movimiento = new lib.sprite11();
        this.noche_movimiento.name = "noche_movimiento";
        this.noche_movimiento.parent = this;
        this.noche_movimiento.alpha = 0;
        this.timeline.addTween(cjs.Tween.get(this.noche_movimiento).wait(1).to({ alpha: 0.02 }, 4).wait(1).to({ alpha: 0.051 }, 3).to({ alpha: 0.078 }, 2).to({ alpha: 0.18 }, 5).to({ alpha: 0.219 }, 2).to({ alpha: 0.301 }, 3).to({ alpha: 0.949 }, 16).wait(1).to({ alpha: 1 }, 0).wait(2));
    }).prototype = p = new cjs.MovieClip();
    p.nominalBounds = new cjs.Rectangle(-237.5, -49, 591, 104);
    (lib.sprite11_1 = function(mode, startPosition, loop) {
        if (loop == null) { loop = false; } this.initialize(mode, startPosition, loop, {});
        this.frame_0 = function() { this.dia_movimiento.gotoAndPlay(2); }
        this.frame_59 = function() { this.stop(); }
        this.timeline.addTween(cjs.Tween.get(this).call(this.frame_0).wait(59).call(this.frame_59).wait(1));
        this.dia_movimiento = new lib.sprite10();
        this.dia_movimiento.name = "dia_movimiento";
        this.dia_movimiento.parent = this;
        this.dia_movimiento.alpha = 0;
        this.timeline.addTween(cjs.Tween.get(this.dia_movimiento).to({ alpha: 0.988 }, 53).wait(1).to({ alpha: 1 }, 0).wait(6));
    }).prototype = p = new cjs.MovieClip();
    p.nominalBounds = new cjs.Rectangle(-382.4, -54, 700.7, 104);
    (lib.sprite7 = function(mode, startPosition, loop) {
        if (loop == null) { loop = false; } this.initialize(mode, startPosition, loop, {});
        this.frame_0 = function() { this.stop();
            this.parent.day_night(); }
        this.frame_1 = function() {}
        this.frame_2 = function() {}
        this.timeline.addTween(cjs.Tween.get(this).call(this.frame_0).wait(1).call(this.frame_1).wait(1).call(this.frame_2).wait(1));
        this.dia = new lib.sprite11_1();
        this.dia.name = "dia";
        this.dia.parent = this;
        this.dia.setTransform(382.4, 54);
        this.noche = new lib.sprite12();
        this.noche.name = "noche";
        this.noche.parent = this;
        this.noche.setTransform(237.5, 49);
        this.timeline.addTween(cjs.Tween.get({}).to({ state: [] }).to({ state: [{ t: this.dia }] }, 1).to({ state: [{ t: this.noche }] }, 1).wait(1));
        this.instance = new lib.shape6("synched", 0);
        this.instance.parent = this;
        this.timeline.addTween(cjs.Tween.get(this.instance).wait(3));
    }).prototype = p = new cjs.MovieClip();
    p.nominalBounds = new cjs.Rectangle(0, 0, 605, 104);
    (lib.animated_header = function(mode, startPosition, loop) {
        if (loop == null) { loop = false; } this.initialize(mode, startPosition, loop, {});
        this.frame_0 = function() {
            this.stop();
            nochedia = new Date();
            var seconds = nochedia.getSeconds();
            var minutes = nochedia.getMinutes();
            var hours = nochedia.getHours();
            this.dia = true;
            if (hours >= 6 || hours <= 17) { this.dia = true; }
            if (hours >= 18 || hours <= 5) { this.dia = false; }
            this.day_night = function() { if (this.dia) { this.tg.gotoAndStop(1); } else { this.tg.gotoAndStop(2); } }
        }
        this.timeline.addTween(cjs.Tween.get(this).call(this.frame_0).wait(1));
        this.clock_mc = new lib.sprite22();
        this.clock_mc.name = "clock_mc";
        this.clock_mc.parent = this;
        this.clock_mc.setTransform(360, 99);
        this.timeline.addTween(cjs.Tween.get(this.clock_mc).wait(1));
        this.top = new lib.sprite16();
        this.top.name = "top";
        this.top.parent = this;
        this.top.setTransform(350, 67);
        this.timeline.addTween(cjs.Tween.get(this.top).wait(1));
        this.instance = new lib.shape9("synched", 0);
        this.instance.parent = this;
        this.instance.setTransform(350, 132);
        this.timeline.addTween(cjs.Tween.get(this.instance).wait(1));
        var mask = new cjs.Shape();
        mask._off = true;
        mask.graphics.p("EgmfAHtIigjIQgsgthYAXQhZAWgnApIAAsVMAisgAKQObAFZOgLQHfgDIIgmQAIA9ACAyQACAxgGAqQgHArAIBBIgHITQgZgxhggIQhhgIgtA0QgtAzgaCSg");
        mask.setTransform(347.4, 151.7);
        this.tg = new lib.sprite7();
        this.tg.name = "tg";
        this.tg.parent = this;
        this.tg.setTransform(50, 94);
        var maskedShapeInstanceList = [this.tg];
        for (var shapedInstanceItr = 0; shapedInstanceItr < maskedShapeInstanceList.length; shapedInstanceItr++) { maskedShapeInstanceList[shapedInstanceItr].mask = mask; }
        this.timeline.addTween(cjs.Tween.get(this.tg).wait(1));
        this.instance_1 = new lib.shape4("synched", 0);
        this.instance_1.parent = this;
        this.instance_1.setTransform(350, 145.5);
        this.timeline.addTween(cjs.Tween.get(this.instance_1).wait(1));
        this.instance_2 = new lib.shape2("synched", 0);
        this.instance_2.parent = this;
        this.instance_2.setTransform(350, 47, 1, 1.15);
        this.timeline.addTween(cjs.Tween.get(this.instance_2).wait(1));
    }).prototype = p = new cjs.MovieClip();
    p.nominalBounds = new cjs.Rectangle(350, 98.5, 700, 198.7);
    lib.properties = { id: 'A1C62C307CCA81458AE949DB14BBDFD2', width: 700, height: 197, fps: 22, color: "#000000", opacity: 1.00, manifest: [{ src: "/header_images/image1.png", id: "image1" }, { src: "/header_images/image1_1.png", id: "image1_1" }, { src: "/header_images/image10.png", id: "image10" }, { src: "/header_images/image12.png", id: "image12" }, { src: "/header_images/image14.png", id: "image14" }, { src: "/header_images/image2.png", id: "image2" }, { src: "/header_images/image3.png", id: "image3" }, { src: "/header_images/image3_1.png", id: "image3_1" }, { src: "/header_images/image4.png", id: "image4" }, { src: "/header_images/image5.png", id: "image5" }, { src: "/header_images/image6.png", id: "image6" }, { src: "/header_images/image7.png", id: "image7" }, { src: "/header_images/image8.png", id: "image8" }, { src: "/header_images/image8_1.png", id: "image8_1" }, { src: "/header_images/image9.png", id: "image9" }], preloads: [] };
    (lib.Stage = function(canvas) { createjs.Stage.call(this, canvas); }).prototype = p = new createjs.Stage();
    p.setAutoPlay = function(autoPlay) { this.tickEnabled = autoPlay; }
    p.play = function() { this.tickEnabled = true;
        this.getChildAt(0).gotoAndPlay(this.getTimelinePosition()) }
    p.stop = function(ms) { if (ms) this.seek(ms);
        this.tickEnabled = false; }
    p.seek = function(ms) { this.tickEnabled = true;
        this.getChildAt(0).gotoAndStop(lib.properties.fps * ms / 1000); }
    p.getDuration = function() { return this.getChildAt(0).totalFrames / lib.properties.fps * 1000; }
    p.getTimelinePosition = function() { return this.getChildAt(0).currentFrame / lib.properties.fps * 1000; }
    an.bootcompsLoaded = an.bootcompsLoaded || [];
    if (!an.bootstrapListeners) { an.bootstrapListeners = []; }
    an.bootstrapCallback = function(fnCallback) { an.bootstrapListeners.push(fnCallback); if (an.bootcompsLoaded.length > 0) { for (var i = 0; i < an.bootcompsLoaded.length; ++i) { fnCallback(an.bootcompsLoaded[i]); } } };
    an.compositions = an.compositions || {};
    an.compositions['A1C62C307CCA81458AE949DB14BBDFD2'] = { getStage: function() { return exportRoot.getStage(); }, getLibrary: function() { return lib; }, getSpriteSheet: function() { return ss; }, getImages: function() { return img; } };
    an.compositionLoaded = function(id) { an.bootcompsLoaded.push(id); for (var j = 0; j < an.bootstrapListeners.length; j++) { an.bootstrapListeners[j](id); } }
    an.getComposition = function(id) { return an.compositions[id]; }
})(createjs = createjs || {}, AdobeAn = AdobeAn || {});
var createjs, AdobeAn;