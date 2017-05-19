#include <iostream>
#include <vector>
#include <memory>
#include <string>
#include "../ez-lib/ez-draw++.hpp"

using namespace std;

class Point {
public:
  Point(int x = 0, int y = 0) : m_x(x), m_y(y) {
  }

  int x() const {
    return m_x;
  }

  int y() const {
    return m_y;
  }

  int &x() {
    return m_x;
  }

  int &y() {
    return m_y;
  }

  void set(const int x, const int y) {
    m_x = x;
    m_y = y;
  }

private:
  int m_x, m_y;
};

bool operator==(const Point &l, const Point &r) {
  return l.x() == r.x() and l.y() == r.y();
}

Point operator+(const Point &l, const Point &r) {
  return Point(l.x()+r.x(), l.y()+r.y());
}

Point operator+(const Point &p, const int number) {
  return Point(p.x()+number, p.y()+number);
}

Point operator-(const Point &l, const Point &r) {
  return Point(l.x()-r.x(), l.y()-r.y());
}

Point operator-(const Point &p, const int number) {
  return Point(p.x()-number, p.y()-number);
}

bool operator<(const Point &l, const Point &r) {
  return l.x() < r.x() and l.y() < r.y();
}

class Canvas {
public:
  explicit Canvas(EZWindow &window) : m_window(window) {}

  unsigned int width() const {
    return m_window.getWidth();
  }

  unsigned int height() const {
    return m_window.getHeight();
  }

  void clear() const {
    m_window.clear();
  }

  void setColor(const EZColor color) {
    m_window.setColor(color);
  }

  void setThick(unsigned int thick=1) {
    m_window.setThick(thick);
  }

  void fillCircle(const Point &topRight, const Point &bottomLeft) {
    m_window.fillCircle(topRight.x(), topRight.y(), bottomLeft.x(), bottomLeft.y());
  }

  void drawText(const EZAlign align, const Point &pos, const std::string &text) {
    m_window.drawText(align, pos.x(), pos.y(), text);
  }

  void drawLine(const Point &first, const Point &second) {
    m_window.drawLine(first.x(), first.y(), second.x(), second.y());
  }

  void drawRectangle(const Point &topRight, const Point &bottomLeft) {
    m_window.drawRectangle(topRight.x(), topRight.y(), bottomLeft.x(), bottomLeft.y());
  }

private:
  EZWindow &m_window;
};

class GraphicsItem {
public:
  typedef std::vector<GraphicsItem*> GraphicsItemList;

  enum GraphicsTypes { //mouse movable type ?
    UndefinedType = 0x0,
    ItemType = 0x1,
    PointType = 0x2,
    TextType = 0x4,
    ShapeType = 0x6,
    LineType = 0x8,
    TriangleType = 0x10,
    RectangleType = 0x12
  };

  enum SearchTypes {
    DirectChildren,
    ChildrenRecursively
  };

  explicit GraphicsItem(GraphicsItem *parent = nullptr)
  : m_parent(nullptr), m_children(), m_anchor(), m_color(ez_black), m_thick(1), m_isVisible(true)
  {
    setParent(parent);
  }

  virtual ~GraphicsItem() {
    cerr << "GraphicsItem deleted " << this << endl;
  }

  GraphicsItem *parent() const {
    return m_parent;
  }

  void setParent(GraphicsItem *parent) {
    if (m_parent == parent)
      return;

    if (m_parent) {
      for (size_t i = 0; i < m_parent->m_children.size(); ++i) {
        if (m_parent->m_children[i].get() == this) {
          m_parent->m_children[i].release();
          m_parent->m_children.erase(m_parent->m_children.begin()+i);
        }
      }
    }
    m_parent = parent;
    if (parent) {
      parent->m_children.push_back(std::unique_ptr<GraphicsItem>(this));
    }
  }

  virtual GraphicsTypes type() const {
    return ItemType;
  }

  GraphicsItemList children(const GraphicsTypes filter = UndefinedType, const SearchTypes option = ChildrenRecursively) const {
    GraphicsItemList list;
    for (auto &ptr : m_children) {
      if (option == ChildrenRecursively) {
        GraphicsItemList sublist = ptr->children(filter, option);
        list.insert(list.end(), sublist.begin(), sublist.end());
      }
      if (filter == UndefinedType or ptr->type() == filter)
        list.push_back(ptr.get());
    }
    return list;
  }

  Point anchor() const {
    if (m_parent)
      return m_anchor + m_parent->anchor();
    else
      return m_anchor;
  }

  void setAnchor(const Point &anchor) {
    m_anchor = anchor;
  }

  EZColor color() const {
    return m_color;
  }

  void setColor(const EZColor color) {
    m_color = color;
  }

  unsigned int thick() const {
    return m_thick;
  }

  void setThick(unsigned int thick = 1) {
    m_thick = thick;
  }

  bool isVisible() const {
    return m_isVisible;
  }

  void setIsVisible(const bool isVisible = true) {
    m_isVisible = isVisible;
  }

  void draw(Canvas *canvas) {
    if (!m_isVisible)
      return;

    for (auto &ptr : m_children)
      ptr->draw(canvas);
    if(canvas) {
      canvas->setColor(m_color);
      canvas->setThick(m_thick);
    }
    meDraw(canvas);
  }

  bool isOver(const Point &p) {
    if (!m_isVisible)
      return false;

    bool result = false;
    for (auto &ptr : m_children)
      result |= ptr->isOver(p);
    return result || meIsOver(p);
  }

protected:
  virtual void meDraw(Canvas *canvas) {}
  virtual bool meIsOver(const Point &p) { return m_anchor == p; }

private:
  GraphicsItem *m_parent;
  vector<unique_ptr<GraphicsItem>> m_children;
  Point m_anchor;
  EZColor m_color;
  unsigned int m_thick;
  bool m_isVisible;
};

class GraphicsPoint : public GraphicsItem
{
public:
  explicit GraphicsPoint(GraphicsItem *parent = nullptr)
  : GraphicsItem(parent), m_radius(5)
  {
  }

  explicit GraphicsPoint(const Point &anchor, GraphicsItem *parent = nullptr)
  : GraphicsPoint(parent)
  {
    setAnchor(anchor);
  }

  unsigned int radius() const
  {
    return m_radius;
  }

  void setRadius(unsigned int radius)
  {
    m_radius = radius;
  }

  GraphicsTypes type() const {
    return PointType;
  }

protected:
  void meDraw(Canvas *canvas)
  {
    if (canvas)
      canvas->fillCircle(anchor() - m_radius, anchor() + m_radius);
  }

  bool meIsOver(const Point &p)
  {
    return anchor() - m_radius < p and p < anchor() + m_radius;
  }

private:
  unsigned int m_radius;
};

class GraphicsText : public GraphicsItem {
public:
  explicit GraphicsText(GraphicsItem *parent = nullptr) : GraphicsItem(parent), m_text(""), m_align(EZAlign::TL) {}

  explicit GraphicsText(const string &text, GraphicsItem *parent = nullptr) : GraphicsText(parent) {
    m_text = text;
  }

  string text() const {
    return m_text;
  }

  void setText(const string &text = "") {
    m_text = text;
  }

  EZAlign align() const {
    return m_align;
  }

  void setAlign(const EZAlign align = EZAlign::TL) {
    m_align = align;
  }

  GraphicsTypes type() const {
    return TextType;
  }

protected:
  void meDraw(Canvas *canvas)
  {
    if (canvas)
      canvas->drawText(m_align, anchor(), m_text);
  }

  bool meIsOver(const Point &p)
  {
    return false;
  }

private:
  string m_text;
  EZAlign m_align;
};

class GraphicsRectangle : public GraphicsItem
{
public:
  explicit GraphicsRectangle(GraphicsItem *parent = nullptr)
  : GraphicsItem(parent), m_topLeft(nullptr), m_bottomRight(nullptr)
  {
    m_topLeft = new GraphicsPoint(this);
    m_bottomRight = new GraphicsPoint(this);
  }

  GraphicsItem *topLeft() {
    return m_topLeft;
  }

  GraphicsItem *bottomRight() {
    return m_bottomRight;
  }

  GraphicsTypes type() const {
    return RectangleType;
  }

protected:
  void meDraw(Canvas *canvas)
  {
    if (canvas)
      canvas->drawRectangle(topLeft()->anchor(), bottomRight()->anchor());
  }

  bool meIsOver(const Point &p)
  {
    return topLeft()->anchor() < p and p < bottomRight()->anchor();
  }

private:
  unsigned int m_radius;
  GraphicsItem *m_topLeft, *m_bottomRight;
};

class GraphicsShape : public GraphicsItem {
public:
  explicit GraphicsShape(GraphicsItem *parent = nullptr) : GraphicsItem(parent), m_points() {}

  GraphicsTypes type() const {
    return ShapeType;
  }

protected:
  void meDraw(Canvas *canvas)
  {
    if (canvas)
      for (size_t i = 0; i < m_points.size(); ++i)
        canvas->drawLine(m_points[i]->anchor(), m_points[(i+1)%m_points.size()]->anchor());
  }

protected:
  GraphicsItemList m_points;
};

class GraphicsLine : public GraphicsShape {
public:
  explicit GraphicsLine(GraphicsItem *parent = nullptr) : GraphicsShape(parent)
  {
    GraphicsPoint *first = new GraphicsPoint(this);
    GraphicsPoint *second = new GraphicsPoint(this);
    m_points.push_back(first);
    m_points.push_back(second);
  }

  GraphicsItem *first() {
    return m_points[0];
  }

  GraphicsItem *second() {
    return m_points[1];
  }

  GraphicsTypes type() const {
    return LineType;
  }
};

class GraphicsTriangle : public GraphicsShape {
public:
  explicit GraphicsTriangle(GraphicsItem *parent = nullptr) : GraphicsShape(parent)
  {
    GraphicsPoint *first = new GraphicsPoint(this);
    GraphicsPoint *second = new GraphicsPoint(this);
    GraphicsPoint *third = new GraphicsPoint(this);
    m_points.push_back(first);
    m_points.push_back(second);
    m_points.push_back(third);
  }

  GraphicsItem *first() {
    return m_points[0];
  }

  GraphicsItem *second() {
    return m_points[1];
  }

  GraphicsItem *third() {
    return m_points[2];
  }

  GraphicsTypes type() const {
    return TriangleType;
  }
};

class GraphicsCircle : public GraphicsShape {
};

class Window : public EZWindow
{
public:
  Window() : EZWindow(), m_canvas(*this), m_scene(), currentItem(nullptr) {
    GraphicsPoint *point = new GraphicsPoint(&m_scene);
    point->setColor(ez_blue);
    GraphicsText *text = new GraphicsText("Je suis super fort !!!", point);
    text->setColor(ez_red);
    GraphicsText *text1 = new GraphicsText("EZDraw c'est rigolo ^^", point);
    text1->setAnchor(Point(40, 30));
    text1->setColor(ez_green);
    text1->setIsVisible(false);

    GraphicsPoint *point2 = new GraphicsPoint(&m_scene);
    point2->setColor(ez_yellow);
    GraphicsText *text2 = new GraphicsText("Bonjour les gens !!!!", point2);
    text2->setColor(ez_red);

    GraphicsLine *line = new GraphicsLine(&m_scene);
    line->second()->setAnchor(Point(40, 0));

    GraphicsTriangle *triangle = new GraphicsTriangle(&m_scene);
    triangle->first()->setAnchor(Point(50, 10));
    triangle->second()->setAnchor(Point(40, 20));
    triangle->third()->setAnchor(Point(60, 20));

    GraphicsRectangle *rectangle = new GraphicsRectangle(&m_scene);
    rectangle->topLeft()->setAnchor(Point(70, 70));
    rectangle->bottomRight()->setAnchor(Point(90, 90));
  }

  void buttonPress(int x, int y, int button) {
    for (GraphicsItem *item : m_scene.children(GraphicsItem::PointType)) {
      if (item->isOver(Point(x, y)))
        currentItem = item;
    }
  }

  void buttonRelease(int x, int y, int button) {
    currentItem = nullptr;
  }

  void motionNotify(int x, int y, int button) {
    if (currentItem) {
      currentItem->setAnchor(Point(x, y));
    }
    sendExpose();
  }

  void expose() {
    m_scene.draw(&m_canvas);
  }

private:
  Canvas m_canvas;
  GraphicsItem m_scene;
  GraphicsItem *currentItem;
};

int main() {
  EZDraw d;
  Window w;
  d.mainLoop();
  return 0;
}
