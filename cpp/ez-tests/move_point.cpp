#include <iostream>
#include <vector>
#include <memory>
#include <string>
#include <cmath>
#include <cstdint>
#include <sstream>
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

ostream &operator<<(ostream &os, const Point &p) {
  return os << p.x() << " " << p.y();
}

bool operator<(const Point &l, const Point &r) {
  return l.x() < r.x() and l.y() < r.y();
}

class Color {
public:
  enum Colors {
    Black = 0x000000,
    White = 0xFFFFFF,
    Grey = 0x969696,
    Red = 0xFF0000,
    Green = 0x00FF00,
    Blue = 0x0000FF,
    Yellow = 0xFFFF00,
    Cyan = 0x00FFFF,
    Mangenta = 0xFF00FF
  };

  explicit Color(const Colors color = Black) : m_color(color) {}

  Color(const uint8_t red, const uint8_t green, const uint8_t blue)
  : m_color(EZWindow::getRGB(red, green, blue))
  {}

  Color(const double hue, const double saturation, const double value)
  : m_color(EZWindow::getHSV(hue, saturation, value))
  {}

  explicit Color(const ulong grey) : m_color(EZWindow::getGrey(grey)) {}

  uint8_t red() const {
    return (m_color & Red) >> 16;
  }

  void setRed(const uint8_t red) {
    m_color &= ~Red;
    m_color |= (red << 16);
  }

  uint8_t green() const {
    return (m_color & Green) >> 8;
  }

  void setGreen(const uint8_t green) {
    m_color &= ~Green;
    m_color |= (green << 8);
  }

  uint8_t blue() const {
    return m_color & Blue;
  }

  void setBlue(const uint8_t blue) {
    m_color &= ~Blue;
    m_color |= blue;
  }

  uint32_t hexa() const {
    return m_color;
  }

  std::string hexaStr() const {
    std::stringstream buf;
    buf << "0x" << std::hex << m_color;
    return buf.str();
  }

private:
  uint32_t m_color;
};

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

  void setThick(const unsigned int thick = 1) {
    m_window.setThick(thick);
  }

  void drawPoint(const int x, const int y) {
    m_window.drawPoint(x, y);
  }

  void drawPoint(const Point &p) {
    m_window.drawPoint(p.x(), p.y());
  }

  void drawLine(const int firstX, const int firstY, const int secondX, const int secondY) {
    m_window.drawLine(firstX, firstY, secondX, secondY);
  }

  void drawLine(const Point &first, const Point &second) {
    m_window.drawLine(first.x(), first.y(), second.x(), second.y());
  }

  void drawRectangle(const int topLeftX, const int topLeftY, const int bottomRightX, const int bottomRightY, const bool isFill = false) {
    if (isFill)
      m_window.fillRectangle(topLeftX, topLeftY, bottomRightX, bottomRightY);
    else
      m_window.drawRectangle(topLeftX, topLeftY, bottomRightX, bottomRightY);
  }

  void drawRectangle(const Point &topLeft, const Point &bottomRight, const bool isFill = false) {
    drawRectangle(topLeft.x(), topLeft.y(), bottomRight.x(), bottomRight.y(), isFill);
  }

  void drawCircle(const int topLeftX, const int topLeftY, const int bottomRightX, const int bottomRightY, const bool isFill = false) {
    if (isFill)
      m_window.fillCircle(topLeftX, topLeftY, bottomRightX, bottomRightY);
    else
      m_window.drawCircle(topLeftX, topLeftY, bottomRightX, bottomRightY);
  }

  void drawCircle(const Point &topLeft, const Point &bottomRight, const bool isFill = false) {
    drawCircle(topLeft.x(), topLeft.y(), bottomRight.x(), bottomRight.y(), isFill);
  }

  void drawTriangle(const int firstX, const int firstY, const int secondX, const int secondY, const int thirdX, const int thirdY, const bool isFill = false) {
    if (isFill)
      m_window.fillTriangle(firstX, firstY, secondX, secondY, thirdX, thirdY);
    else
      m_window.drawTriangle(firstX, firstY, secondX, secondY, thirdX, thirdY);
  }

  void drawTriangle(const Point &first, const Point &second, const Point &third, const bool isFill = false) {
    drawTriangle(first.x(), first.y(), second.x(), second.y(), third.x(), third.y(), isFill);
  }

  void drawText(const EZAlign align, const int x, const int y, const std::string &text) {
    m_window.drawText(align, x, y, text);
  }

  void drawText(const EZAlign align, const Point &pos, const std::string &text) {
    m_window.drawText(align, pos.x(), pos.y(), text);
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
    RectangleType = 0x12,
    PolygonType = 0x14,
    AnchorType = 0x16,
    CircleType = 0x18,
    EllipseType = 0x20
  };

  enum SearchTypes {
    DirectChildren,
    ChildrenRecursively
  };

  explicit GraphicsItem(GraphicsItem *parent = nullptr)
  : m_parent(nullptr), m_children(), m_anchor(), m_color(ez_black), m_thick(1), m_isFill(false), m_isVisible(true)
  {
    setParent(parent);
  }

  virtual ~GraphicsItem() {
    setParent(nullptr);
    cerr << "GraphicsItem deleted :" << this << " of type : " << type() << endl;
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
    if (m_parent)
      m_parent->m_children.push_back(std::unique_ptr<GraphicsItem>(this));
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
    return m_anchor;
  }

  virtual void setAnchor(const Point &anchor) {
    m_anchor = anchor;
  }

  Point absolute() const {
    if (m_parent)
      return m_anchor + m_parent->absolute();
    else
      return m_anchor;
  }

  virtual void setAbsolute(const Point &pos) {
    if (m_parent)
      setAnchor(pos - m_parent->absolute());
    else
      setAnchor(pos);
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

  bool isFill() const {
    return m_isFill;
  }

  void setFill(const bool fill) {
    m_isFill = fill;
  }

  bool isVisible() const {
    return m_isVisible;
  }

  void setVisible(const bool isVisible = true) {
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
  virtual bool meIsOver(const Point &absoluteP) { return absolute() == absoluteP; }

private:
  GraphicsItem *m_parent;
  vector<unique_ptr<GraphicsItem>> m_children;
  Point m_anchor;
  EZColor m_color;
  unsigned int m_thick;
  bool m_isFill;
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
      canvas->drawCircle(absolute() - m_radius, absolute() + m_radius, isFill());
  }

  bool meIsOver(const Point &absoluteP)
  {
    return absolute() - m_radius < absoluteP and absoluteP < absolute() + m_radius;
  }

private:
  unsigned int m_radius;
};

class GraphicsAnchor : public GraphicsPoint {
public:
  explicit GraphicsAnchor(GraphicsItem *parent = nullptr) : GraphicsPoint(parent) {
    setColor(ez_red);
  }

  void setAnchor(const Point &anchor) {
    if(parent())
      parent()->setAnchor(anchor);
  }

  void setAbsolute(const Point &pos) {
    if (parent()) {
      if (parent()->parent())
        parent()->setAnchor(pos - parent()->parent()->absolute());
      else
        parent()->setAnchor(pos);
    }
  }

  GraphicsTypes type() const {
    return PointType;//FIXME AnchorType;
  }
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
      canvas->drawText(m_align, absolute(), m_text);
  }

  bool meIsOver(const Point &absoluteP)
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
    m_topLeft = new GraphicsAnchor(this);
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
      canvas->drawRectangle(topLeft()->absolute(), bottomRight()->absolute(), isFill());
  }

  bool meIsOver(const Point &absoluteP)
  {
    return topLeft()->absolute() < absoluteP and absoluteP < bottomRight()->absolute();
  }

private:
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
    if (canvas) {
      if (isFill() && m_points.size() >= 3)
        for (size_t i = 2; i < m_points.size(); ++i)
          canvas->drawTriangle(m_points[0]->absolute(), m_points[i-1]->absolute(), m_points[i]->absolute(), true);
      else
        for (size_t i = 0; i < m_points.size(); ++i)
          canvas->drawLine(m_points[i]->absolute(), m_points[(i+1)%m_points.size()]->absolute());
    }
  }

protected:
  GraphicsItemList m_points;
};

class GraphicsPolygon : public GraphicsShape {
public:
  explicit GraphicsPolygon(GraphicsItem *parent = nullptr) : GraphicsShape(parent) {
    GraphicsPoint *a = new GraphicsAnchor(this);
    m_points.push_back(a);
  }

  GraphicsItem *newPoint() {
    GraphicsItem *item = new GraphicsPoint(this);
    m_points.push_back(item);
    return item;
  }

  void popPoint() {
    if (m_points.size() > 2) {
      delete m_points.back();
      m_points.pop_back();
    }
  }

  size_t nbPoints() const {
    return m_points.size();
  }

  void setNbPoints(const size_t nb) {
    if (nb <= 1)
      return;

    while (nb > nbPoints())
      newPoint();

    while (nbPoints() > nb)
      popPoint();
  }

  GraphicsTypes type() const {
    return PolygonType;
  }
};

class GraphicsLine : public GraphicsShape {
public:
  explicit GraphicsLine(GraphicsItem *parent = nullptr) : GraphicsShape(parent)
  {
    GraphicsPoint *first = new GraphicsAnchor(this);
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
    GraphicsPoint *first = new GraphicsAnchor(this);
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
public:
  explicit GraphicsCircle(GraphicsItem *parent) : GraphicsShape(parent) {
    GraphicsItem *center = new GraphicsAnchor(this);
    GraphicsItem *radius = new GraphicsPoint(this);
    m_points.push_back(center);
    m_points.push_back(radius);
  }

  GraphicsItem *center() {
    return m_points[0];
  }

  GraphicsItem *radius() {
    return m_points[1];
  }

  GraphicsTypes type() const {
    return CircleType;
  }

protected:
  void meDraw(Canvas *canvas)
  {
    if (canvas) {
      Point distP = radius()->absolute() - center()->absolute();
      int dist = hypot(distP.x(), distP.y());
      canvas->drawCircle(center()->absolute() - dist, center()->absolute() + dist, isFill());
    }
  }

  bool meIsOver(const Point &absoluteP)
  {
    return false;
  }
};

class GraphicsEllipse : public GraphicsShape {
public:
  explicit GraphicsEllipse(GraphicsItem *parent) : GraphicsShape(parent) {
    GraphicsItem *center = new GraphicsAnchor(this);
    GraphicsItem *radius = new GraphicsPoint(this);
    m_points.push_back(center);
    m_points.push_back(radius);
  }

  GraphicsItem *center() {
    return m_points[0];
  }

  //change the name ?
  GraphicsItem *radius() {
    return m_points[1];
  }

  GraphicsTypes type() const {
    return EllipseType;
  }

protected:
  void meDraw(Canvas *canvas)
  {
    if (canvas)
      canvas->drawCircle(center()->absolute(), radius()->absolute(), isFill());
  }

  bool meIsOver(const Point &absoluteP)
  {
    return false;
  }
};

class Window : public EZWindow
{
public:
  Window() : EZWindow(), m_canvas(*this), m_scene(), currentItem(nullptr) {
    GraphicsPoint *point = new GraphicsPoint(&m_scene);
    point->setAbsolute({50, 50});
    point->setColor(ez_blue);
    GraphicsText *text = new GraphicsText("Je suis super fort !!!", point);
    text->setAnchor({0, 10});
    text->setColor(ez_red);
    GraphicsText *text1 = new GraphicsText("EZDraw c'est rigolo ^^", point);
    text1->setAnchor({10, 20});
    text1->setColor(ez_green);

    GraphicsPoint *point2 = new GraphicsPoint(&m_scene);
    point2->setAbsolute({100, 50});
    point2->setColor(ez_yellow);
    GraphicsText *text2 = new GraphicsText("Bonjour les gens !!!!", point2);
    text2->setColor(ez_red);

    GraphicsLine *line = new GraphicsLine(&m_scene);
    line->setAbsolute({50, 100});
    line->second()->setAnchor({80, 20});

    GraphicsTriangle *triangle = new GraphicsTriangle(&m_scene);
    triangle->setFill(true);
    triangle->setAbsolute({200, 20});
    triangle->second()->setAnchor(Point(-30, 30));
    triangle->third()->setAnchor(Point(30, 30));

    GraphicsRectangle *rectangle = new GraphicsRectangle(&m_scene);
    rectangle->setThick(5);
    rectangle->setAbsolute({100, 100});
    rectangle->bottomRight()->setAnchor({80, 50});

    GraphicsPolygon *polygon = new GraphicsPolygon(&m_scene);
    polygon->setFill(true);
    polygon->setAbsolute({200, 100});
    polygon->setNbPoints(10);
    polygon->setNbPoints(5);

    GraphicsCircle *circle = new GraphicsCircle(&m_scene);
    circle->setAbsolute({100, 300});
    circle->radius()->setAnchor({50, 50});

    GraphicsEllipse *ellipse = new GraphicsEllipse(&m_scene);
    ellipse->setAbsolute({200, 300});
    ellipse->radius()->setAnchor({100, 50});
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
      currentItem->setAbsolute(Point(x, y));
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
