library components.dragula;

import 'package:angular2/angular2.dart';
import 'package:dragula/dragula.dart';
import 'dart:html';
import 'package:js/js.dart';

@Component(
    selector: 'dragula',
    templateUrl: 'dragula.html',
    styleUrls: const ['dragula.css'],
    directives: const [],
    encapsulation: ViewEncapsulation.None)
class Dragula implements OnInit {
  ElementRef ref;

  @Input() List<Element> containers;
  @Input() String direction;
  @Input() bool removeOnSpill;
  @Input() bool revertOnSpill;
  @Input() bool copySortSource;
  @Input() Element mirrorContainer;
  @Input() OnDrag onDrag;
  @Input() OnDragEnd onDragEnd;
  @Input() OnDrop onDrop;
  @Input() OnCancel onCancel;
  @Input() OnShadow onShadow;
  @Input() OnOver onOver;
  @Input() OnOut onOut;
  @Input() OnCloned onCloned;
  @Input() dynamic copy = false;
  @Input() Function accepts;
  @Input() Function moves;
  @Input() Function invalid;
  @Input() Function isContainer;

  Dragula(this.ref);

  onInit() {
    if (copy is Function) {
      copy = allowInterop(copy);
    }
    if (accepts != null) accepts = allowInterop(accepts);
    if (moves != null) moves = allowInterop(moves);
    if (invalid != null) invalid = allowInterop(invalid);
    if (isContainer != null) isContainer = allowInterop(isContainer);

    containers = (ref.nativeElement as Element).children.toList();

    Drake drake = dragula(containers,
        direction: direction,
        mirrorContainer: mirrorContainer,
        removeOnSpill: removeOnSpill,
        revertOnSpill: revertOnSpill,
        copy: copy,
        accepts: accepts,
        invalid: invalid,
        isContainer: isContainer,
        moves: moves);
    if (onDrag != null) drake.on('drag', allowInterop(onDrag));
    if (onDragEnd != null) drake.on('dragend', allowInterop(onDragEnd));
    if (onDrop != null) drake.on('drop', allowInterop(onDrop));
    if (onCancel != null) drake.on('cancel', allowInterop(onCancel));
    if (onShadow != null) drake.on('shadow', allowInterop(onShadow));
    if (onOver != null) drake.on('over', allowInterop(onOver));
    if (onOut != null) drake.on('out', allowInterop(onOut));
    if (onCloned != null) drake.on('cloned', allowInterop(onCloned));
  }
}

typedef bool Copy(Element el, Element source);
typedef bool Accepts(
    Element el, Element target, Element source, Element sibling);
typedef bool Moves(Element el, Element target, Element source, Element sibling);

typedef void OnDrag(Element el, Element source);
typedef void OnDragEnd(Element el);
typedef void OnDrop(
    Element el, Element target, Element source, Element sibling);
typedef void OnCancel(Element el, Element container, Element source);
typedef void OnShadow(Element el, Element container, Element source);
typedef void OnOver(Element el, Element container, Element source);
typedef void OnOut(Element el, Element container, Element source);
typedef void OnCloned(Element clone, Element original, String type);
