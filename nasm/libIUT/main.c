#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <curses.h>

#ifdef WIN32
 /* Nécessaire pour la fonction Sleep qui dépend du système. */
 #include <Windows.h>
 #include <Winbase.h>
#endif

#include <panel.h>

extern int go_asm(void);

WINDOW	*win=NULL;
int	maxx=0,maxy=0;

void une_pause_c_msg(const char *msg,int pair)
{
 WINDOW *w2=NULL;
 int len=strlen(msg);

 if(!(w2=newwin(3,len+2,maxy-3,maxx-(len+2))))
  {
   move(maxy-1,maxx-len);
   bkgdset(COLOR_PAIR(3)|A_BOLD);
   printw(msg);
   bkgdset(A_NORMAL);
   getch();
  }
 else
  {
   PANEL * panel = NULL;
   panel = new_panel(w2);
   wbkgdset(w2,COLOR_PAIR(pair)|A_BOLD);
   box(w2,COLOR_PAIR(pair)|A_BOLD|ACS_VLINE,COLOR_PAIR(pair)|A_BOLD|ACS_HLINE);
   mvwprintw(w2,1,1,msg);
   update_panels();
   doupdate();
   nodelay(w2,FALSE);
   noecho();
   curs_set(0);
   wgetch(w2);
   curs_set(1);
   echo();
   hide_panel(panel);
   del_panel(panel);
   delwin(w2);
   update_panels();
   doupdate();
  }
}

void une_pause_c(void)
{ une_pause_c_msg("Appuyez sur une touche pour continuer !",2); }

void sleep_ms_c(unsigned int delay)
{
#ifdef WIN32
 Sleep(delay);
#else
 usleep(delay*1000);
#endif
}

int main(int argc,char *argv[])
{
 /*int retval=0;*/
 win=initscr();
 nodelay( stdscr, FALSE );
 echo();
 refresh();
 maxx=getmaxx(win);
 maxy=getmaxy(win);
 if (has_colors())
  start_color();
 init_pair(1,COLOR_WHITE,COLOR_BLACK);
 init_pair(2,COLOR_WHITE,COLOR_BLUE);
 init_pair(3,COLOR_WHITE,COLOR_RED);
 bkgdset(COLOR_PAIR(1));
 clear();
 syncok(win,TRUE);
 scrollok(win,TRUE);
 /*retval=*/go_asm();
 une_pause_c_msg("Fin du programme. Appuyez sur une touche.",3);
 /*clear();*/
 endwin();
 /*return retval;*/
 return 0;
}
